module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.8.0"

  name    = var.cluster_name
  kubernetes_version = "1.33"

  endpoint_public_access = true

  enable_irsa = true

  #Auto Mode
  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_cluster_creator_admin_permissions = true

}
