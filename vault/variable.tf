variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "default"
}

variable "public-key" {
  default = "~/Keypairs/vault-key.pub"
}

variable "all_cidr" {
  default = "0.0.0.0/0"
}

variable "port_ssh" {
  default = "22"
}

# proxy port for vault
variable "port_vault" {
  default = "8200"
}

variable "port_http" {
  default = "80"
}

variable "port_https" {
  default = "443"
}

variable "sg-protocol" {
  default = "tcp"
}

variable "vault-ami" {
  default = "ami-01dd271720c1ba44f"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "domain_name" {
  default = "wehabot.com"
}

variable "aws_region" {
  default = "eu-west-1"
}