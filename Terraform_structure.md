# Root module for provisioning Edge Services Account in AWS using Terraform
# Structure:
# modules/
#   - waf/
#   - cloudfront/
#   - route53/
#   - redirect_service/
#   - iam/
# main.tf
# variables.tf
# outputs.tf
# README.md

// main.tf
module "waf" {
  source = "./modules/waf"
  waf_name = var.waf_name
  tags = var.tags
}

module "cloudfront" {
  source = "./modules/cloudfront"
  waf_web_acl_arn = module.waf.web_acl_arn
  tags = var.tags
}

module "route53" {
  source = "./modules/route53"
  zone_name = var.public_zone_name
  tags = var.tags
}

module "redirect_service" {
  source = "./modules/redirect_service"
  domain_name = var.redirect_domain
  zone_id = module.route53.zone_id
  tags = var.tags
}

module "iam" {
  source = "./modules/iam"
  tags = var.tags
}

// variables.tf
variable "waf_name" { type = string }
variable "public_zone_name" { type = string }
variable "redirect_domain" { type = string }
variable "tags" { type = map(string) default = {} }

// outputs.tf
output "cloudfront_distribution_id" {
  value = module.cloudfront.distribution_id
}

output "route53_zone_id" {
  value = module.route53.zone_id
}

output "waf_web_acl_arn" {
  value = module.waf.web_acl_arn
}

// README.md
# Edge Services Terraform Stack

This Terraform stack provisions a production-ready Edge Services Account with:
- AWS WAF Web ACL
- CloudFront Distribution with WAF attached
- Route53 Public Hosted Zone
- ALB-based Redirection Service
- Minimal IAM roles and policies

## Structure
```bash
.
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
└── modules/
    ├── waf/
    ├── cloudfront/
    ├── route53/
    ├── redirect_service/
    └── iam/
```

## Usage
1. Customize `terraform.tfvars` with your settings.
2. Run:
```bash
terraform init
terraform apply
```

## Notes
- The design allows modular updates to each component.
- Use Terraform Cloud or S3 remote state backend for production.
- Follow IAM least-privilege best practices.
