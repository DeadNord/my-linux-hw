variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster-hw-10"
}

variable "vpc_name" {
  default = "vpc-hw-10"
}

variable "instance_type" {
  description = "EC2 instance type for the worker nodes"
  type        = string
  default     = "t2.medium"
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "ecr-repo-18062025214500"
}

// github credentials

variable "github_pat" {
  description = "GitHub Personal Access Token"
  type        = string
}

variable "github_user" {
  description = "GitHub username"
  type        = string
}

variable "github_repo_url" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch name"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub project name"
  type        = string
}

variable "rds_name" {
  description = "Base name for RDS resources"
  type        = string
  default     = "db"
}

variable "rds_use_aurora" {
  description = "Create Aurora cluster when true"
  type        = bool
  default     = false
}

variable "rds_engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15.3"
}

variable "rds_instance_class" {
  description = "Instance class for DB"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ for RDS instance"
  type        = bool
  default     = false
}

variable "rds_db_name" {
  description = "Initial database name"
  type        = string
  default     = "exampledb"
}

variable "rds_username" {
  description = "Master username"
  type        = string
  default     = "admin"
}

variable "rds_password" {
  description = "Master password"
  type        = string
}

variable "rds_port" {
  description = "Database port"
  type        = number
  default     = 5432
}
