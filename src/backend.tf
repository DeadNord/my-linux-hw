terraform {
  required_version = ">= 1.6.0"
  backend "local" {}

  backend "s3" {
    bucket         = var.backend_bucket # ← вкажіть свій бакет
    key            = "lesson-5/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.backend_dynamodb_table
    encrypt        = true
  }
}
