# Security Group for Bastion Host and Ansible Server
resource "aws_security_group" "Bastion-Ansible_SG" {
  name        = "Bastion-Ansible-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description      = "Allow ssh access"
    from_port        = var.port_ssh
    to_port          = var.port_ssh
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
  }

  tags = {
    Name = var.tag-Bastion-Ansible-SG
  }
}

# Security Group for Docker Server
resource "aws_security_group" "Docker_SG" {
  name        = "Docker-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description      = "Allow ssh access"
    from_port        = var.port_ssh
    to_port          = var.port_ssh
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow proxy access"
    from_port        = var.port_proxy
    to_port          = var.port_proxy
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow http access"
    from_port        = var.port_http
    to_port          = var.port_http
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow https access"
    from_port        = var.port_https
    to_port          = var.port_https
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
  }

  tags = {
    Name = var.tag-Docker-SG
  }
}

# Security Group for Jenkins Server
resource "aws_security_group" "Jenkins_SG" {
  name        = "Jenkins-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description      = "Allow ssh access"
    from_port        = var.port_ssh
    to_port          = var.port_ssh
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow proxy access"
    from_port        = var.port_proxy
    to_port          = var.port_proxy
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
  }

  tags = {
    Name = var.tag-Jenkins-SG
  }
}

# Security Group for Sonarqube Server
resource "aws_security_group" "Sonarqube_SG" {
  name        = "Sonarqube-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description      = "Allow ssh access"
    from_port        = var.port_ssh
    to_port          = var.port_ssh
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow sonarqube access"
    from_port        = var.port_sonar
    to_port          = var.port_sonar
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
  }

  tags = {
    Name = var.tag-Sonarqube-SG
  }
}

# Security Group for Nexus Server
resource "aws_security_group" "Nexus_SG" {
  name        = "Nexus-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description      = "Allow ssh access"
    from_port        = var.port_ssh
    to_port          = var.port_ssh
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow nexus access"
    from_port        = var.port_proxy_nexus
    to_port          = var.port_proxy_nexus
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
  }

  tags = {
    Name = var.tag-Nexus-SG
  }
}

# Security Group for MySQL RDS Database
resource "aws_security_group" "MySQL_RDS_SG" {
  name        = "MySQL-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description      = "Allow MySQL access"
    from_port        = var.port_mysql
    to_port          = var.port_mysql
    protocol         = "tcp"
    cidr_blocks      = [var.priv_sub1_cidr, var.priv_sub2_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
  }

  tags = {
    Name = var.tag-MySQL-SG
  }
}
