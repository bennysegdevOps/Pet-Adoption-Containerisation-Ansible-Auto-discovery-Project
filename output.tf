output "ansible" {
  value = module.ansible.ansible-public_ip
}
output "jenkins" {
  value = module.jenkins.jenkins_private_ip
}
output "sonarqube" {
  value = module.sonarqube.sonarqube_public_ip
}
output "nexus" {
  value = module.nexus.nexus_public_ip
}
output "bastion" {
  value = module.bastion-host.bastion-host-public_ip
}
output "prod-loadbalancer" {
  value = module.prod-alb.prod-alb-dns
}
output "stage-loadbalancer" {
  value = module.stage-alb.stage-alb-dns
}
output "database" {
  value = module.database.database_arn
}
output "name" {
  value = module.jenkins-lb.jenkins_lb-arn
}