# Edge Services Terraform Stack

This Terraform stack provisions a **production-ready Edge Services Account** with:

- AWS WAF Web ACL
- CloudFront Distribution with WAF attached
- Route 53 Public Hosted Zone
- ALB-based Redirection Service
- Minimal IAM roles and policies for automation and integration

---

## 📁 Structure
```
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

---

## 🚀 Usage

1. Customize `terraform.tfvars` with your environment-specific values:

```hcl
waf_name           = "airnz-edge-waf"
public_zone_name   = "example.airnz.co.nz"
redirect_domain    = "www.example.airnz.co.nz"
tags = {
  env        = "prod"
  team       = "cloud-platform"
  managed-by = "terraform"
}
```

2. Initialize and apply:

```bash
terraform init
terraform apply
```

> 💡 We recommend using **Terraform Cloud** or **S3 backend with DynamoDB locking** for production environments.

---

## 🔧 Files Overview

### `main.tf`
Declares modules and passes necessary variables to each:

```hcl
module "waf" {
  source     = "./modules/waf"
  waf_name   = var.waf_name
  tags       = var.tags
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  waf_web_acl_arn    = module.waf.web_acl_arn
  tags               = var.tags
}

module "route53" {
  source     = "./modules/route53"
  zone_name  = var.public_zone_name
  tags       = var.tags
}

module "redirect_service" {
  source       = "./modules/redirect_service"
  domain_name  = var.redirect_domain
  zone_id      = module.route53.zone_id
  tags         = var.tags
}

module "iam" {
  source = "./modules/iam"
  tags   = var.tags
}
```

### `variables.tf`
Defines configurable inputs for reusability:

```hcl
variable "waf_name"           { type = string }
variable "public_zone_name"   { type = string }
variable "redirect_domain"    { type = string }
variable "tags"               { type = map(string) default = {} }
```

### `outputs.tf`
Exports useful references post-deployment:

```hcl
output "cloudfront_distribution_id" {
  value = module.cloudfront.distribution_id
}

output "route53_zone_id" {
  value = module.route53.zone_id
}

output "waf_web_acl_arn" {
  value = module.waf.web_acl_arn
}
```

---

## 🧱 Modules
Each module contains its own `main.tf`, `variables.tf`, and optionally `outputs.tf`.
- `modules/waf`: Creates WAF Web ACL and default rules
- `modules/cloudfront`: Deploys CloudFront with WAF
- `modules/route53`: Creates public hosted zone
- `modules/redirect_service`: Provisions ALB/NLB for redirection
- `modules/iam`: Creates minimal IAM roles for edge services

---

## 🛡️ Best Practices

- Follow **least privilege IAM** when integrating other AWS services.
- Use **CloudFormation StackSets** or **AWS Org SCPs** for account-wide controls.
- Enable **logging and monitoring** for all services (WAF logs, CloudFront logs, etc.)

---

## 📌 Next Steps
Would you like the detailed module scaffolds next (e.g., for `waf` or `cloudfront`)?
We can include secure defaults and best practices built-in.
