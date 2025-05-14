# --------------------------------------------------
# Environment-Specific Variable Values for Edge Services
# --------------------------------------------------

project_prefix     = "airnz-edge"
waf_name           = "airnz-edge-waf"
public_zone_name   = "example.airnz.co.nz"
redirect_domain    = "www.example.airnz.co.nz"
logging_bucket_arn = "arn:aws:s3:::airnz-edge-logs"

tags = {
  env        = "prod"
  team       = "cloud-platform"
  managed-by = "terraform"
}
