resource "aws_elb" "jenkins-lb" {
  name                        = var.jenkins-alb
  security_groups             = [var.jenkins-SG]
  subnets                     = [var.subnet-id]
  listener {
    instance_port     = var.port_proxy
    instance_protocol = "http"
    lb_port           = var.port_http
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }
  instances                   = [var.jenkins_instance]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
  Name                        = var.jenkins-alb
  }
}