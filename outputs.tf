# Output the CloudFront domain name
output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
  description = "CloudFront distribution domain name"
}

# Output the ALB DNS name from the redirect service
output "alb_dns_name" {
  value = module.redirect_service.alb_dns_name
  description = "ALB DNS name for redirection service"
}

# Output the WAF Web ACL ARN
output "waf_web_acl_arn" {
  value = module.waf.web_acl_arn
  description = "ARN of the WAF Web ACL"
}
