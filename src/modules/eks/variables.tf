variable "cluster_name" {}
variable "cluster_version" { default = "1.30" }
variable "vpc_id" {}
variable "private_subnet_ids" { type = list(string) }
variable "public_subnet_ids"  { type = list(string) }
