output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "load_balancer_dns" {
  description = "The DNS name of the Load Balancer"
  value       = module.compute.lb_dns_name
}


output "website_url" {
  description = "link access Website Todo App"
  value       = "http://${module.compute.alb_dns_name}"
}