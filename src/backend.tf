terraform {
  backend "s3" {
    bucket         = "my-tfstate-bucket"
    key            = "lesson-7/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "my-lock-table"
    encrypt        = true
  }
}
