/*
  Variables for Route53 module
*/

variable "public_zone_name" {
  description = "Domain name for the public hosted zone"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Route53 hosted zone"
  type        = map(string)
  default     = {}
}
