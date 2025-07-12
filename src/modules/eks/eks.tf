module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = concat(var.private_subnet_ids, var.public_subnet_ids)
  vpc_id          = var.vpc_id

  # одного node-група для простоти
  eks_managed_node_groups = {
    default = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
      instance_types = ["t3.medium"]
    }
  }
}
