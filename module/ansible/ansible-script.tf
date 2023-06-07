locals {
  ansible_user_data = <<-EOF
#!/bin/bash

# update instance and install ansible
sudo yum update -y
sudo dnf install -y ansible-core

# install wget, unzip and aws cli
sudo yum install wget -y
sudo yum install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ln -svf /usr/local/bin/aws /usr/bin/aws
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'

# configure aws cli on instance
aws configure set aws_access_key_id 
aws configure set aws_secret_access_key
aws configure set default.region
aws configure set default.output

EOF
}