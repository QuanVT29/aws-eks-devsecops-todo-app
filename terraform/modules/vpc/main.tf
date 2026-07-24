# Use the official AWS VPC community module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true 
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true


  
  # Specify the public subnets here for the ALB Controller to set up an internet-facing ALB.
  public_subnet_tags = {
    "kubernetes.io/role/elb"                            = 1
    "kubernetes.io/cluster/${var.project_name}-cluster" = "shared"
  }

  # Specify to the ALB Controller that this is a private subnet for internal routing.
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"                   = 1
    "kubernetes.io/cluster/${var.project_name}-cluster" = "shared"
  }
}