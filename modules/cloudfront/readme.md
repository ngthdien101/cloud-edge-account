The CloudFront distribution origin points to your ALB-based redirect service domain.

You can optionally provide an S3 bucket for CloudFront logs via logging_bucket.

The distribution uses the default CloudFront certificate; replace with ACM cert if you have a custom domain.
