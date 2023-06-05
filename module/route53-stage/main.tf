# Route 53 zone stage environment
data "aws_route53_zone" "stage_route53" {
  name          = var.stage_domain_name
  private_zone  = false
}

# Route 53 record 
resource "aws_route53_record" "stage" {
  zone_id                   = data.aws_route53_zone.stage_route53.id
  name                      = var.stage_domain_name
  type                      = "A"
  alias {
    name                    = var.dns_name
    zone_id                 = var.zone_id
    evaluate_target_health  = true
  }
}

# ACM certificate # DNS Validation with Route 53 (registry)
resource "aws_acm_certificate" "stage_acm_certificate" {
  domain_name             = var.stage_domain_name
  # subject_alternative_names = ["*.var.domain_name"]
  validation_method       = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# Route53 record validation
resource "aws_route53_record" "stage_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.stage_acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.stage_route53.zone_id
}

#create acm certificate validition
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.stage_acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_record : record.fqdn]
}
