output "frontend_repo_url" {
  description = "URL of ECR Frontend"
  value       = aws_ecr_repository.frontend.repository_url
}

output "backend_repo_url" {
  description = "URL of ECR Backend"
  value       = aws_ecr_repository.backend.repository_url
}