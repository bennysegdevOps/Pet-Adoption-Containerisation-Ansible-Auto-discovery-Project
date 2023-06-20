output "jenkins-lb-dns" {
  value = aws_elb.jenkins-lb.dns_name
}

output "jenkins_lb-arn" {
  value = aws_elb.jenkins-lb.arn
}