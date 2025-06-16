module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"

  cluster_endpoint_public_access = true

  # cluster_addons = {
  #   coredns = {}
  #   eks-pod-identity-agent = {}
  #   kube-proxy             = {}
  #   vpc-cni = {}
  #   aws-ebs-csi-driver = {}
  #   metrics-server = {
  #     most_recent = true
  #   }
  # }

  access_entries = {
    super-admin = {
      principal_arn = local.SSO_AdministratorAccess_role

      policy_associations = {
        cluster-admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  #Auto Mode
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  # Managed Node group
  # eks_managed_node_groups = {
  #   managed_node = {
  #     ami_type       = "AL2023_x86_64_STANDARD"
  #     instance_types = ["t2.medium"]
  #
  #     min_size = 1
  #     max_size = 3
  #     desired_size = 1
  #
  #     subnet_ids = module.vpc.private_subnets
  #
  #   }
  # }
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = false

}
