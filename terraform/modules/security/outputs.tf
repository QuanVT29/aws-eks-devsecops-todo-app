output "alb_controller_policy_arn" {
  description = "ARN of the IAM Policy granting permissions to the AWS Load Balancer Controller"
  value       = aws_iam_policy.alb_controller_policy.arn
}


output "alb_controller_role_arn" {
  description = "ARN of the IAM Role for AWS Load Balancer Controller"
  value       = aws_iam_role.alb_controller_role.arn
}