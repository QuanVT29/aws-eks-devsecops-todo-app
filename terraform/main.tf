module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "eks" {
  source          = "./modules/eks"
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

# Truyền OIDC Provider từ EKS sang Security để tạo Role IRSA
module "security" {
  source            = "./modules/security"
  project_name      = var.project_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider     = module.eks.oidc_provider
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

# Tự động tạo Namespace 'todo-app' trên EKS trước khi tạo Secret
resource "kubernetes_namespace" "todo_app" {
  metadata {
    name = "todo-app"
  }
  depends_on = [module.eks]
}

# Tạo Secret chứa URI MongoDB
resource "kubernetes_secret" "app_secrets" {
  metadata {
    name      = "app-secrets"
    namespace = kubernetes_namespace.todo_app.metadata[0].name
  }

  data = {
    mongo_uri = var.mongo_uri
  }

  depends_on = [kubernetes_namespace.todo_app]
}