output "stage-alb-dns" {
  value = aws_lb.stage-alb.dns_name
}

output "stage-alb-zone_id" {
  value = aws_lb.stage-alb.zone_id
}

output "stage-alb-arn" {
  value = aws_lb.stage-alb.arn
}

output "stage-target-group-arn" {
  value = aws_lb_target_group.target_group.arn
}