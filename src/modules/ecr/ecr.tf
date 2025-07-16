resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name      = var.repository_name
    Terraform = "true"
  }
}
