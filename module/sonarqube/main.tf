resource "aws_instance" "sonarqube" {
  ami                         = var.ami_ubuntu
  instance_type               = var.instance-type
  key_name                    = var.key-name
  vpc_security_group_ids      = [var.sonarqube-SG]
  subnet_id                   = var.subnetid
  associate_public_ip_address = true
  
  user_data                   = local.sonarqube_user_data

  tags = {
    Name = var.tag-sonarqube
  }
}
