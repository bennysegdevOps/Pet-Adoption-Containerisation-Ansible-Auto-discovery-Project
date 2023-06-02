# Security Group for Bastion Host and Ansible Server
resource "aws_security_group" "Bastion-Ansible_SG" {
  name        = "${local.name}-Bastion-Ansible"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name = "${local.name}-Bastion-Ansible-SG"
  }
}

# Security Group for Docker Server
resource "aws_security_group" "Docker_SG" {
  name        = "${local.name}-Docker"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name = "${local.name}-Docker-SG"
  }
}

# Security Group for Jenkins Server
resource "aws_security_group" "Jenkins_SG" {
  name        = "${local.name}-Jenkins"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name = "${local.name}-Jenkins-SG"
  }
}

# Security Group for Sonarqube Server
resource "aws_security_group" "Sonarqube_SG" {
  name        = "${local.name}-Sonarqube"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name = "${local.name}-Sonarqube-SG"
  }
}

# Security Group for Nexus Server
resource "aws_security_group" "Nexus_SG" {
  name        = "${local.name}-Nexus"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name = "${local.name}-Nexus-SG"
  }
}

# # Security Group for MySQL RDS Database
# resource "aws_security_group" "MySQL_RDS_SG" {
#   name        = "${local.name}-MySQL-RDS"
#   description = "Allow inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description      = "Allow MySQL access"
#     from_port        = var.port_mysql
#     to_port          = var.port_mysql
#     protocol         = "tcp"
#     cidr_blocks      = [var.priv_sub1_cidr, var.priv_sub2_cidr]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = [var.all_cidr]
#   }

#   tags = {
#     Name = "${local.name}-MySQL-SG"
#   }
# }
