output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.eks.cluster_ca_certificate
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "state_bucket_name" {
  description = "Terraform state S3 bucket"
  value       = module.s3_backend.bucket_id
}

output "dynamodb_table_name" {
  description = "DynamoDB lock table"
  value       = module.s3_backend.dynamodb_table_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
