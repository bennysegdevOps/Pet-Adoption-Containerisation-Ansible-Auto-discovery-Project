output "jenkins_private_ip" {
  value = aws_instance.jenkins-server.private_ip
}

output "jenkins_server" {
  value = aws_instance.jenkins-server.id
}