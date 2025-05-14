/*
  Outputs from the WAF module
*/

output "web_acl_arn" {
  description = "ARN of the created WAF Web ACL"
  value       = aws_wafv2_web_acl.this.arn
}
