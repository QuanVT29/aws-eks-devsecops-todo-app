variable "aws_region" {
  description = "AWS region for all resources"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project used for tagging and naming resources"
  default     = "todo-app"
}

variable "mongo_uri" {
  type        = string
  description = "MongoDB Atlas Connection String"
  sensitive   = true
}