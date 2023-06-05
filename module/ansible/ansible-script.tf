locals {
  ansible_user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo dnf install -y ansible-core

EOF
}