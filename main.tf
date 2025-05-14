// Configure the AWS provider
provider "aws" {
  region = var.aws_region
}

// Provision a WAF Web ACL with default rules
module "waf" {
  source    = "./modules/waf"
  waf_name  = var.waf_name
  tags      = var.tags
}

# Create a public hosted zone in Route 53
module "route53" {
  source             = "./modules/route53"
  public_zone_name  = var.public_zone_name
  tags              = var.tags
}

# Deploy the redirection service using ALB/NLB
module "redirect_service" {
  source          = "./modules/redirect_service"
  redirect_domain = var.redirect_domain
  tags            = var.tags
}

# Configure CloudFront with WAF and integrate with Route 53
module "cloudfront" {
  source              = "./modules/cloudfront"
  waf_web_acl_arn     = module.waf.web_acl_arn
  redirect_domain     = var.redirect_domain
  zone_id             = module.route53.zone_id
  tags                = var.tags
}

# Create minimal IAM roles/policies for automation and integration
module "iam" {
  source = "./modules/iam"
  tags   = var.tags
}
