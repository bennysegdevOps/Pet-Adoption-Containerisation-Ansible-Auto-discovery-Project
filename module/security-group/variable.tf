variable "all_cidr" {}
variable "vpc-id" {}
variable "port_ssh" {}
variable "port_proxy" {}  #proxy port for Jenkins and Docker 
variable "port_http" {}
variable "port_https" {}
variable "port_sonar" {}
variable "port_proxy_nexus" {}
variable "port_proxy_nexus2" {}
variable "port_mysql" {}
variable "tag-Bastion-Ansible-SG" {}
variable "tag-Docker-SG" {}
variable "tag-Jenkins-SG" {}
variable "tag-Sonarqube-SG" {}
variable "tag-Nexus-SG" {}
variable "tag-MySQL-SG" {}
variable "priv_sub1_cidr" {}
variable "priv_sub2_cidr" {}