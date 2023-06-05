output "jenkins_private_ip" {
  value = aws_instance.jenkins-server.private_ip
}