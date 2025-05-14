/*
  Outputs from Redirect Service module
*/

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.redirect_alb.dns_name
}
