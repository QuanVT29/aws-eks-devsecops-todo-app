output "alb_controller_policy_arn" {
  description = "ARN of the IAM Policy granting permissions to the AWS Load Balancer Controller"
  value       = aws_iam_policy.alb_controller_policy.arn
}