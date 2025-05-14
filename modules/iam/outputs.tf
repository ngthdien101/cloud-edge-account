/*
  Outputs from IAM module
*/

output "cloudfront_logging_role_arn" {
  description = "ARN of the CloudFront logging IAM role"
  value       = aws_iam_role.cloudfront_logging_role.arn
}

output "alb_monitoring_role_arn" {
  description = "ARN of the ALB monitoring IAM role"
  value       = aws_iam_role.alb_monitoring_role.arn
}
