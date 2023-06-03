output "Bastion-Ansible_SG-id" {
  value = aws_security_group.Bastion-Ansible_SG.id
}

output "Docker-SG-id" {
  value = aws_security_group.Docker_SG.id
}

output "Jenkins-SG-id" {
  value = aws_security_group.Jenkins_SG.id
}

output "Sonarqube-SG-id" {
  value = aws_security_group.Sonarqube_SG.id
}

output "Nexus-SG-id" {
  value = aws_security_group.Nexus_SG.id
}

output "MySQL-SG-id" {
  value = aws_security_group.MySQL_RDS_SG.id
}