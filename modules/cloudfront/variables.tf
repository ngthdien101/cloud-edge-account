/*
  Variables for CloudFront module
*/

variable "waf_web_acl_arn" {
  description = "ARN of the WAF Web ACL to associate"
  type        = string
}

variable "redirect_domain" {
  description = "Domain name of the redirection service origin"
  type        = string
}

variable "waf_name" {
  description = "Name of the WAF Web ACL, used for logging prefix"
  type        = string
}

variable "logging_bucket" {
  description = "S3 bucket name to store CloudFront access logs"
  type        = string
  default     = ""  // Can be overridden to enable logging
}

variable "tags" {
  description = "Tags to apply to CloudFront distribution"
  type        = map(string)
  default     = {}
}
