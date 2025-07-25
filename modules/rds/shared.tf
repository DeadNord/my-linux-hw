resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  parameter_family = var.engine == "postgres" ? "postgres${split(".", var.engine_version)[0]}" : var.engine == "aurora-postgresql" ? "aurora-postgresql${split(".", var.engine_version)[0]}" : var.engine == "mysql" ? "mysql${split(".", var.engine_version)[0]}.${split(".", var.engine_version)[1]}" : var.engine == "aurora-mysql" ? "aurora-mysql${split(".", var.engine_version)[0]}.${split(".", var.engine_version)[1]}" : var.engine
}

resource "aws_db_parameter_group" "this" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.name}-param-group"
  family = local.parameter_family

  parameter {
    name  = "max_connections"
    value = "100"
  }
  parameter {
    name  = "log_statement"
    value = "none"
  }
  parameter {
    name  = "work_mem"
    value = "65536"
  }
}

resource "aws_rds_cluster_parameter_group" "aurora" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.name}-cluster-param"
  family = local.parameter_family

  parameter {
    name  = "max_connections"
    value = "100"
  }
  parameter {
    name  = "log_statement"
    value = "none"
  }
  parameter {
    name  = "work_mem"
    value = "65536"
  }
}
