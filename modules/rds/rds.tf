resource "aws_db_instance" "this" {
  count                     = var.use_aurora ? 0 : 1
  identifier                = var.name
  allocated_storage         = 20
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids    = [aws_security_group.this.id]
  db_name                   = var.db_name
  username                  = var.username
  password                  = var.password
  port                      = var.port
  multi_az                  = var.multi_az
  parameter_group_name      = var.use_aurora ? null : aws_db_parameter_group.this[0].name
  skip_final_snapshot       = true
}