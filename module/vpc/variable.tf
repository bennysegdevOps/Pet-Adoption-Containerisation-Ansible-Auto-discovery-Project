variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "pub_sub1_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zone_1" {
  default = "eu-west-1a"
}

variable "pub_sub2_cidr" {
  default = "10.0.2.0/24"
}

variable "availability_zone_2" {
  default = "eu-west-1b"
}

variable "priv_sub1_cidr" {
  default = "10.0.3.0/24"
}

variable "priv_sub2_cidr" {
  default = "10.0.4.0/24"
}

variable "all_cidr" {
  default = "0.0.0.0/0"
}

variable "key_name" {
  default = "benny_keypair"
}

variable "public_key" {
  default = "file(~/Keypairs/pacpaad.pub)"
}

variable "private_key" {
  default = "file(~/Keypairs/pacpaad)"
}

