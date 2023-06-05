output "ns-records" {
  value = data.aws_route53_zone.route53.name_servers
}

output "cert-arn" {
  value = aws_acm_certificate.acm_certificate.arn
}