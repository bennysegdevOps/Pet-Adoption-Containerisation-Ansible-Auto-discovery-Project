resource "aws_instance" "ansible-server" {
  ami                                 = var.ami_redhat
  instance_type                       = var.instance_type
  key_name                            = var.key-name
  vpc_security_group_ids              = [var.security-group]
  associate_public_ip_address         = true
  subnet_id                           = var.subnetid
  user_data                           = local.ansible_user_data
  
  tags = {
    Name = var.ansible-server
  }
}
