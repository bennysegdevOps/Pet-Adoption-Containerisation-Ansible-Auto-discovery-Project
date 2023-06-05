resource "aws_instance" "jenkins-server" {
  ami                         = var.ami_redhat
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.jenkins-SG]
  associate_public_ip_address = false
  subnet_id                   = var.subnetid
  user_data                   = local.jenkins_user_data

  tags = {
    Name = var.tag-jenkins
  }
}
