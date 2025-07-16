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
  default     = "hw-7-terraform"
}

variable "backend_dynamodb_table" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "hw-7-terraform-locks"
}
