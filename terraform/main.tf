# Root main.tf - Calls all modules to provision the infrastructure

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "security" {
  source       = "./modules/security"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "compute" {
  source                = "./modules/compute"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  public_subnets        = module.vpc.public_subnets
  ecs_security_group_id = module.security.ecs_sg_id
  lb_security_group_id  = module.security.lb_sg_id
  mongo_uri = var.mongo_uri
}
