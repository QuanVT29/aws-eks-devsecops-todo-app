# Root main.tf

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

 
module "security" {
  source       = "./modules/security"
  project_name = var.project_name
}


# CALL THE NEW EKS MODULE
module "eks" {
  source          = "./modules/eks"
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}


module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}


# Automatically Create Kubernetes Secrets from Terraform
resource "kubernetes_secret" "app_secrets" {
  metadata {
    name      = "app-secrets"
    namespace = "default"
  }

  data = {
    mongo_uri = var.mongo_uri
  }

  # Ensure the EKS cluster is fully set up before creating the Secret.
  depends_on = [module.eks]
}
