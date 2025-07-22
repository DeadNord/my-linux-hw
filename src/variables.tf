variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "project" {
  type    = string
  default = "lesson-7"
}

variable "backend_bucket" {
  description = "S3 bucket name for remote state"
  type        = string
  default     = "hw-8-9-terraform"
}

variable "backend_dynamodb_table" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "hw-8-9-terraform-locks"
}
