variable "bucket_name" {
  type        = string
  description = "S3 bucket for TF state"
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table for state locks"
}
