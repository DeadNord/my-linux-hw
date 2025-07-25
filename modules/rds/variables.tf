variable "name" {
  description = "Base name for RDS resources"
  type        = string
  default     = "db"
}

variable "use_aurora" {
  description = "If true, create Aurora cluster instead of single RDS instance"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Database engine (postgres, mysql, aurora-postgresql, aurora-mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15.3"
}

variable "instance_class" {
  description = "Instance class for DB instance or Aurora instances"
  type        = string
  default     = "db.t3.micro"
}

variable "multi_az" {
  description = "Enable Multi-AZ for RDS instance"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "exampledb"
}

variable "username" {
  description = "Master username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Master password"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the database security group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for DB subnet group"
  type        = list(string)
}

variable "port" {
  description = "Database port"
  type        = number
  default     = 5432
}
