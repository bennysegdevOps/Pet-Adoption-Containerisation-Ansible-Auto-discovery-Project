output "db-subnet-group_id" {
  value = aws_db_subnet_group.db-subnet.id
}

output "database_arn" {
  value = aws_db_instance.mysql_db.arn
}

output "database_id" {
  value = aws_db_instance.mysql_db.id
}