output "load_balancer_dns" {
  description = "The DNS name of the Load Balancer"
  value       = module.compute.lb_dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}