# --------------------------------------------------
# Environment-Specific Variable Values for Edge Services
# --------------------------------------------------

project_prefix     = "org-edge"
waf_name           = "org-edge-waf"
public_zone_name   = "example.org.co.nz"
redirect_domain    = "www.example.org.co.nz"
logging_bucket_arn = "arn:aws:s3:::org-edge-logs"

tags = {
  env           = "prod"
  managed-by    = "cloud-platform"
  applicationid = "AAAAAxxxxxx"
  costcenter    = "12345"
}
