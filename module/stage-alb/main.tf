#Target group for Docker load Balancer
resource "aws_lb_target_group" "target_group" {
  name     = var.tg-name
  port     = var.port_proxy
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5  
    interval            = 30
    timeout             = 5
  }
}

# Application Load Balancer
resource "aws_lb" "stage-alb" {
  name                        = var.stage-alb
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = [var.alb-SG]
  subnets                     = [var.subnet1-id , var.subnet2-id]
  enable_deletion_protection  = false
  tags = {
  Name                        = var.stage-alb
  }
}

# Creating Load balancer Listener for http access
resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn      = aws_lb.stage-alb.arn
  port                   = var.port_http
  protocol               = "HTTP"
  default_action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.target_group.arn
    }
  }
  
# Creating a Load balancer Listener for https access
resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn      = aws_lb.stage-alb.arn
  port                   = var.port_https
  protocol               = "HTTPS"
  ssl_policy             = "ELBSecurityPolicy-2016-08"
  certificate_arn        = "${var.cert-arn}"
  default_action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.target_group.arn
  }
}
