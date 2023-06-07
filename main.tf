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
  port_proxy_nexus2    = "8085"
  port_mysql          = "3306"
  priv_sub1_cidr      = "10.0.3.0/24"
  priv_sub2_cidr      = "10.0.4.0/24"
  tag-Bastion-Ansible-SG = "${local.name}-Bastion-Ansible-SG"
  tag-Docker-SG       = "${local.name}-Docker-SG"
  tag-Jenkins-SG      = "${local.name}-Jenkins-SG"
  tag-Sonarqube-SG    = "${local.name}-Sonarqube-SG"
  tag-Nexus-SG        = "${local.name}-Nexus-SG"
  tag-MySQL-SG        = "${local.name}-MySQL-SG"
}

module "bastion-host" {
  source            = "./module/bastion-host"
  ami_redhat        = "ami-013d87f7217614e10"
  instance-type     = "t2.micro"
  key-name          = module.vpc.key_name
  bastion-SG        = module.security-group.Bastion-Ansible_SG-id
  subnetid          = module.vpc.public_subnet1_id
  private_key       = "file(~/Keypairs/pacpaad)"
  tag-bastion       =  "${local.name}-bastion"
}

module "sonarqube" {
  source            = "./module/sonarqube"
  ami_ubuntu        = "ami-01dd271720c1ba44f" 
  instance-type     = "t2.medium"
  key-name          = module.vpc.key_name
  sonarqube-SG      = module.security-group.Sonarqube-SG-id
  subnetid          = module.vpc.public_subnet1_id
  tag-sonarqube     = "${local.name}-sonarqube"
}

module "ansible" {
  source            = "./module/ansible"
  ami_redhat        = "ami-013d87f7217614e10"
  instance_type     = "t2.medium"
  key-name          = module.vpc.key_name
  ansible-SG        = module.security-group.Bastion-Ansible_SG-id
  subnetid          = module.vpc.public_subnet2_id
  ansible-server    = "${local.name}-ansible"
}

module "jenkins" {
  source          = "./module/jenkins"
  ami_redhat      = "ami-013d87f7217614e10"
  instance_type   = "t2.medium"
  key_name        = module.vpc.key_name
  jenkins-SG      = module.security-group.Jenkins-SG-id
  subnetid        = module.vpc.private_subnet1_id
  tag-jenkins     = "${local.name}-jenkins"
  nr_license_key  = "c605530d3bdfc50e00542ec7f199be7efebaNRAL"
  nexus-ip        = module.nexus.nexus_public_ip
}

module "jenkins-lb" {
  source = "./module/jenkins-lb"
  jenkins-alb = "${local.name}-jenkins-lb"
  jenkins-SG = module.security-group.Jenkins-SG-id
  subnet-id = module.vpc.public_subnet1_id
  jenkins_instance = module.jenkins.jenkins_server
  port_proxy = "8080"
  port_http = "80"
}

module "nexus" {
  source          = "./module/nexus"
  ami_redhat      = "ami-013d87f7217614e10"
  instance_type   = "t2.medium"
  key_name        = module.vpc.key_name
  nexus-SG        = module.security-group.Nexus-SG-id
  subnetid        = module.vpc.public_subnet2_id
  tag-nexus       = "${local.name}-nexus"
  nr_license_key  = "c605530d3bdfc50e00542ec7f199be7efebaNRAL"
}

module "database" {
  source                      = "./module/database"
  subnet1-id                  = module.vpc.private_subnet1_id
  subnet2-id                  = module.vpc.private_subnet2_id
  tag-db-subnet-group         = "${local.name}-dbsubnet-group"
  db_identifier               = "pacpaad-db"
  RDS-SG                      = module.security-group.MySQL-SG-id
  db_name                     = "auto-discovery-db"
  db_engine                   = "mysql"
  db_engine_version           = "5.7"
  db_instance_class           = "db.t3.micro"
  db_username                 = "admin"
  db_password                 = "Admin123@"
  db_parameter_gp_name        = "default.mysql5.7"
  db_storage_type             = "gp2"
}

module "route53" {
  source            = "./module/route53"
  domain_name       = "wehabot.com"
  domain_name2      = "*.wehabot.com"
  stage_domain_name = "stage.wehabot.com"
  prod_domain_name  = "prod.wehabot.com"
  dns_name          = module.stage-alb.stage-alb-dns
  zone_id           = module.stage-alb.stage-alb-zone_id
  dns_name2         = module.prod-alb.prod-alb-dns
  zone_id2          = module.prod-alb.prod-alb-zone_id
}

module "stage-alb" {
  source        = "./module/stage-alb"
  tg-name       = "${local.name}-stage-tg"
  port_proxy    = "8080"
  vpc_id        = module.vpc.vpc_id
  stage-alb     = "${local.name}-stage-alb"
  alb-SG        = module.security-group.Docker-SG-id
  subnet1-id    = module.vpc.public_subnet1_id
  subnet2-id    = module.vpc.public_subnet2_id
  port_http     = "80"
  port_https    = "443"
  cert-arn      = module.route53.cert-arn
}

module "prod-alb" {
  source        = "./module/prod-alb"
  prod-tg       = "${local.name}-prod-tg"
  port_proxy    = "8080"
  vpc_id        = module.vpc.vpc_id
  prod-alb      = "${local.name}-prod-alb"
  alb-SG        = module.security-group.Docker-SG-id
  subnet1-id    = module.vpc.public_subnet1_id
  subnet2-id    = module.vpc.public_subnet2_id
  port_http     = "80"
  port_https    = "443"
  cert-arn      = module.route53.cert-arn
}

module "asg-stage" {
  source                = "./module/asg-stage"
  stage-lt-name         = "${local.name}-stage-LT"
  ami-redhat-id         = "ami-013d87f7217614e10"
  instance_type         = "t2.medium"
  stage-lt-sg           = [module.security-group.Docker-SG-id]
  keypair_name          = module.vpc.key_name
  stage-asg-name        = "${local.name}-stage-ASG"
  vpc-zone-identifier   = [module.vpc.private_subnet1_id , module.vpc.private_subnet2_id]
  tg-arn                = [module.stage-alb.stage-target-group-arn]
  asg-policy            = "${local.name}-stage-asg-policy"
  nexus-ip              = module.nexus.nexus_public_ip
  nr_key                = "c605530d3bdfc50e00542ec7f199be7efebaNRAL"
}

module "asg-prod" {
  source              = "./module/asg-prod"
  prod-lt-name        = "${local.name}-prod-LT"
  ami-redhat-id       = "ami-013d87f7217614e10"
  instance_type       = "t2.medium"
  prod-lt-sg          = [module.security-group.Docker-SG-id]
  keypair_name        = module.vpc.key_name
  prod-asg-name       = "${local.name}-prod-ASG"
  vpc-zone-identifier = [module.vpc.private_subnet1_id , module.vpc.private_subnet2_id]
  tg-arn              = [module.prod-alb.prod-target-group-arn]
  asg-policy          = "${local.name}-prod-asg-policy"
  nexus-ip            = module.nexus.nexus_public_ip
  nr_key              = "c605530d3bdfc50e00542ec7f199be7efebaNRAL"
}