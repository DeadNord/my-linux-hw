#########################################
# Root: подключаем готовые модули
#########################################

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = var.backend_bucket
  table_name  = var.backend_dynamodb_table
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_name           = "lesson-7-vpc"
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "${var.project}-django"
  scan_on_push    = true
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = "${var.project}-cluster"
  cluster_version    = "1.30"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
}
