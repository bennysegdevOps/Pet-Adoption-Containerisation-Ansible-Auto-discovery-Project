output "ansible-public_ip" {
  value = aws_instance.ansible-server.public_ip
}