/*
  Variables for Redirect Service ALB module
*/

variable "redirect_domain" {
  description = "Domain name for the redirect service"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ALB"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the redirect service resources"
  type        = map(string)
  default     = {}
}

/*
// Optional variable for HTTPS listener
variable "certificate_arn" {
  description = "ARN of ACM certificate for HTTPS listener"
  type        = string
  default     = null
}
*/
