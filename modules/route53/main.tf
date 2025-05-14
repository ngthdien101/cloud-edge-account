/*
  Module: Route53 Public Hosted Zone
  Purpose: Create a public Route53 hosted zone for edge services.
  Features:
  - Supports tagging for resource classification and billing
  - Outputs the hosted zone ID for cross-module use
*/

resource "aws_route53_zone" "public_zone" {
  name = var.public_zone_name
  comment = "Public hosted zone for edge services"

  tags = var.tags
}
