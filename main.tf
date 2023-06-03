locals {
  name = "benny-pacpaad"
}

module "vpc" {
  source              = "./module/vpc"
  vpc_cidr            = "10.0.0.0/16"
  pub_sub1_cidr       = "10.0.1.0/24"
  availability_zone_1 = "eu-west-1a"
  pub_sub2_cidr       = "10.0.2.0/24"
  availability_zone_2 = "eu-west-1b"
  priv_sub1_cidr      = "10.0.3.0/24"
  priv_sub2_cidr      = "10.0.4.0/24"
  all_cidr            = "0.0.0.0/0"
  key_name            = "benny_keypair"
  public_key          = "file(~/Keypairs/pacpaad.pub)"
  private_key         = "file(~/Keypairs/pacpaad)"
  tag-vpc             = "${local.name}-vpc"
  tag-public_subnet1  = "${local.name}-public_subnet1"
  tag-public_subnet2  = "${local.name}-public_subnet2"
  tag-private_subnet1 = "${local.name}-private_subnet1"
  tag-private_subnet2 = "${local.name}-private_subnet2"
  tag-igw             = "${local.name}-igw"
  tag-natgw           = "${local.name}-natgw"
  tag-public_RT       = "${local.name}-public_RT"
  tag-private_RT      = "${local.name}-private_RT"
}

module "security-group" {
  source              = "./module/security-group"
  all_cidr            = "0.0.0.0/0"
  vpc-id              = module.vpc.vpc_id
  port_ssh            = "22"
  port_proxy          = "8080"
  port_http           = "80"
  port_https          = "443"
  port_sonar          = "9000"
  port_proxy_nexus    = "8081"
  port_mysql          = "3306"
  tag-Bastion-Ansible-SG = "${local.name}-Bastion-Ansible-SG"
  tag-Docker-SG       = "${local.name}-Docker-SG"
  tag-Jenkins-SG      = "${local.name}-Jenkins-SG"
  tag-Sonarqube-SG    = "${local.name}-Sonarqube-SG"
  tag-Nexus-SG        = "${local.name}-Nexus-SG"
  tag-MySQL-SG        = "${local.name}-MySQL-SG"
}

module "bastion-host" {
  source            = "./module/bastion-host"
  ami               = "ami-013d87f7217614e10"
  instance-type     = "t2.micro"
  key-name          = "benny_keypair"
  security-group    = module.security-group.Bastion-Ansible_SG-id
  subnetid          = module.vpc.public_subnet1_id
  tag-bastion-host  =  "${local.name}-bastion"
}

module "sonarqube" {
  source            = "./module/sonarqube"
  ami               = "ami-01dd271720c1ba44f" 
  instance-type     = "t2.medium"
  key-name          = "benny_keypair"
  security-group    = module.security-group.Sonarqube-SG-id
  subnetid          = module.vpc.public_subnet1_id
  tag-sonarqube-server = "${local.name}-sonarqube"
}

