# checkov:skip=CKV_TF_1: Trust module version
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"          # Use the latest stable version

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = "1.30"     # New Kubernetes version

  # Enable OIDC Provider Automatically
  enable_irsa = true
  
  # Enable public access to the Kubernetes API server for kubectl commands
  cluster_endpoint_public_access = true 

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets 
  control_plane_subnet_ids = var.private_subnets

  # Worker Nodes configuration (Where your Pods will run)
  eks_managed_node_groups = {
    todo_app_nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      # t3.medium (2 vCPUs, 4GB RAM) is the recommended minimum to run EKS smoothly
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  # Grant admin permissions to the user/role running Terraform to manage the cluster
  enable_cluster_creator_admin_permissions = true
}