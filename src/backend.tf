terraform {
  backend "s3" {
    bucket         = "hw-7-terraform"
    key            = "lesson-7/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "hw-7-terraform-locks"
    encrypt        = true
  }
}
