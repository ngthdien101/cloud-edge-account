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

1. Clone repo and create your working branch
2. Customize `terraform.tfvars` with your environment-specific values:

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

2. Raise PR for code review. 

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
