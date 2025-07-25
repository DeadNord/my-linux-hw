output "endpoint" {
  description = "Database endpoint"
  value       = var.use_aurora ? aws_rds_cluster.this[0].endpoint : aws_db_instance.this[0].address
}

output "port" {
  description = "Database port"
  value       = var.port
}

output "security_group_id" {
  description = "Security group ID for the database"
  value       = aws_security_group.this.id
}

output "subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.this.name
}