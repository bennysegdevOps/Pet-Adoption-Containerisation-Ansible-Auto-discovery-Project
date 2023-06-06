output "jenkins-lb-dns" {
  value = aws_elb.jenkins-lb.dns_name
}