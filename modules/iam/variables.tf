/*
  Variables for IAM module
*/

variable "project_prefix" {
  description = "Prefix for naming IAM roles and policies"
  type        = string
  default     = "edge"
}

variable "logging_bucket_arn" {
  description = "ARN of the S3 bucket for CloudFront logs"
  type        = string
}

variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}
