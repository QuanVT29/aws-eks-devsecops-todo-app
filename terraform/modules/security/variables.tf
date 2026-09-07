variable "project_name" {
  description = "Name of the project used as a prefix for IAM resources"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of OIDC Provider from EKS"
  type        = string
}

variable "oidc_provider" {
  description = "OIDC Provider URL from EKS"
  type        = string
}