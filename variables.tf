# AWS region for resource deployment
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

# Name of the Web ACL for WAF
variable "waf_name" {
  description = "Name for the WAF ACL"
  type        = string
}

# Public hosted zone domain name for Route 53
variable "public_zone_name" {
  description = "Route 53 Public Hosted Zone"
  type        = string
}

# Fully qualified domain name for the redirection service
variable "redirect_domain" {
  description = "Domain for redirect service"
  type        = string
}

# Common tags applied to all resources
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
