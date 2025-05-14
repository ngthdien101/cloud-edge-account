/*
  AWS Provider Configuration
  - Region: Set for global services (e.g., Route53, CloudFront)
  - Backend: S3 for remote state management with locking via DynamoDB
*/

provider "aws" {
  region = "us-east-1" # Required for global services like CloudFront and WAF
}

# Optional: use `alias` for modules that may need specific region later
# provider "aws" {
#   alias  = "edge"
#   region = "us-east-1"
# }

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket         = "airnz-terraform-states"
    key            = "edge-services/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
