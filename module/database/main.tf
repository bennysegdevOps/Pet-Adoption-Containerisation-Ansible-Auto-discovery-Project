# database subnet group
resource "aws_db_subnet_group" "db-subnet" {
  name       = "db-subnet-group"
  subnet_ids = [var.subnetid1 , var.subnetid2]

  tags = {
    Name = var.tag-db-subnet-group
    }
}

# MySQL RDS database 
resource "aws_db_instance" "mysql_db" {
  identifier                = var.db_identifier
  db_subnet_group_name      = aws_db_subnet_group.db-subnet.name
  vpc_security_group_ids    = [var.security_group]
  publicly_accessible       = false 
  skip_final_snapshot       = true
  allocated_storage         = 10
  db_name                   = var.db_name
  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  instance_class            = var.db_instance_class
  username                  = var.db_username
  password                  = var.db_password
  parameter_group_name      = var.db_parameter_gp_name
  storage_type              = var.db_storage_type
}