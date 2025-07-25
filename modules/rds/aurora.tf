resource "aws_rds_cluster" "this" {
  count                     = var.use_aurora ? 1 : 0
  cluster_identifier        = "${var.name}-cluster"
  engine                    = var.engine
  engine_version            = var.engine_version
  database_name             = var.db_name
  master_username           = var.username
  master_password           = var.password
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids    = [aws_security_group.this.id]
  port                      = var.port
  skip_final_snapshot       = true
  db_cluster_parameter_group_name = var.use_aurora ? aws_rds_cluster_parameter_group.aurora[0].name : null
}

resource "aws_rds_cluster_instance" "writer" {
  count              = var.use_aurora ? 1 : 0
  identifier         = "${var.name}-writer"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = var.instance_class
  engine             = var.engine
  engine_version     = var.engine_version
}