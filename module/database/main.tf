# database subnet group
resource "aws_db_subnet_group" "db-subnet" {
  name       = "db-subnet-group"
  subnet_ids = [var.subnet1-id , var.subnet2-id]

  tags = {
    Name = var.tag-db-subnet-group
    }
}

# MySQL RDS database 
resource "aws_db_instance" "mysql_db" {
  identifier                = "multi-az-rds"
  db_subnet_group_name      = aws_db_subnet_group.db-subnet.name
  vpc_security_group_ids    = [var.RDS-SG]
  publicly_accessible       = false 
  skip_final_snapshot       = true
  allocated_storage         = 10
  db_name                   = var.db_name
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t3.micro"
 # multi_az                  = true 
  username                  = var.db_username
  password                  = var.db_password
  parameter_group_name      = "default.mysql5.7"
  storage_type              = "gp2"
}