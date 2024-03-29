resource "aws_instance" "bastion-host" {
  ami                             = var.ami_redhat
  instance_type                   = var.instance-type
  key_name                        = var.key-name
  vpc_security_group_ids          = [var.bastion-SG]
  subnet_id                       = var.subnetid
  associate_public_ip_address     = true
  user_data                       = <<-EOF
  #!/bin/bash
  echo "${var.private_key}" >> /home/ubuntu/pacpaad
  sudo chmod 400 /home/ubuntu/pacpaad
  sudo hostname bastion-host
  EOF

  tags = {
    Name = var.tag-bastion
  }
}