# IAM Policy granting permissions for AWS Load Balancer Controller to interact with AWS ALB/NLB

resource "aws_iam_policy" "alb_controller_policy" {
  name        = "${var.project_name}-AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "IAM policy for AWS Load Balancer Controller in EKS"

  # Official standard policy file from AWS for EKS Ingress Controller
  policy = file("${path.module}/iam_policy.json")
}