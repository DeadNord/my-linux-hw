output "endpoint" {
  description = "RDS endpoint for connecting to the database"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].endpoint : aws_db_instance.standard[0].endpoint
}

output "port" {
  description = "Database port"
  value       = var.port
}

output "security_group_id" {
  description = "Security group ID for the database"
  value       = aws_security_group.rds.id
}

output "subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.default.name
}
