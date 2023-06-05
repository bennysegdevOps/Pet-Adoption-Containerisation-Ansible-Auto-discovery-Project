output "prod-alb-dns" {
  value = aws_lb.prod-alb.dns_name
}

output "prod-alb-zone_id" {
  value = aws_lb.prod-alb.zone_id
}

output "prod-alb-arn" {
  value = aws_lb.prod-alb.arn
}

output "prod-target-group-arn" {
  value = aws_lb_target_group.target_group.arn
}