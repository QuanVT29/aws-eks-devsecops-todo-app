# terraform/modules/compute/variables.tf

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "The Security Group ID for ECS tasks"
  type        = string
}

variable "lb_security_group_id" {
  description = "The Security Group ID for the Load Balancer"
  type        = string
}

variable "mongo_uri" {
  type        = string
  description = "The connection string for MongoDB Atlas"
  sensitive   = true     # Hide password when run terraform plan/apply
}