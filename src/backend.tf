terraform {
  backend "s3" {
    bucket         = "hw-8-9-terraform"
    key            = "lesson-7/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "hw-8-9-terraform-locks"
    encrypt        = true
  }
}
