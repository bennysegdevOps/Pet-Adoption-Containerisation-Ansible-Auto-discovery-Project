variable "all_cidr" {
  default = "0.0.0.0/0"
}

variable "port_ssh" {
  default = "22"
}

# proxy port for Jenkins and Docker 
variable "port_proxy" {
  default = "8080"
}

# http port access
variable "port_http" {
  default = "80"
}

# https port access
variable "port_https" {
  default = "443"
}

# sonarqube port access
variable "port_sonar" {
  default = "9000"
}

# nexus port access
variable "port_proxy_nexus" {
  default = "8081"
}

# Mysql port access
variable "port_mysql" {
  default = "3306"
}
