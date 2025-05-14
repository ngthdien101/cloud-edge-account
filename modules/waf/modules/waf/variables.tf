/*
  Variables for WAF Web ACL module
*/

variable "waf_name" {
  description = "Name for the WAF Web ACL"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the WAF Web ACL"
  type        = map(string)
  default     = {}
}
