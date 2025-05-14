/*
  Outputs from Route53 module
*/

output "zone_id" {
  description = "ID of the created Route53 hosted zone"
  value       = aws_route53_zone.public_zone.zone_id
}
