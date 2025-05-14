/*
  Module: WAF Web ACL
  Purpose: Create an AWS WAF Web ACL with managed rule groups suitable for edge security.
  Notes:
  - Uses AWS Managed Rules for baseline protection
  - Allows tagging for resource organization and cost allocation
*/

resource "aws_wafv2_web_acl" "this" {
  name        = var.waf_name
  description = "WAF Web ACL for edge services"
  scope       = "CLOUDFRONT"   // CloudFront is global scope

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.waf_name
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
    }
  }

  // Additional managed rules can be added here as needed.

  tags = var.tags
}
