/*
  Module: CloudFront Distribution
  Purpose: Provision a CloudFront distribution for the edge services with WAF protection.
  Features:
  - Attach WAF Web ACL
  - Default cache behavior with redirect domain origin
  - Enable logging for audit and diagnostics
  - Supports tagging for resource tracking
*/

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  comment             = "CloudFront distribution for edge services"
  default_root_object = "index.html"

  origins {
    domain_name = var.redirect_domain
    origin_id   = "redirect-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.3"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "redirect-origin"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  web_acl_id = var.waf_web_acl_arn

  logging_config {
    bucket         = var.logging_bucket
    include_cookies = false
    prefix         = "${var.waf_name}/"
  }

  tags = var.tags
}
