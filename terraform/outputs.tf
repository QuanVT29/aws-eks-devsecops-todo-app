output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "ecr_frontend_url" {
  description = "ECR Repository URL for Frontend"
  value       = module.ecr.frontend_repo_url
}

output "ecr_backend_url" {
  description = "ECR Repository URL for Backend"
  value       = module.ecr.backend_repo_url
}