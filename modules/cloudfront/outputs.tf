/*
  Outputs from CloudFront module
*/

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}
