/*
  Module: IAM Roles & Policies for Edge Services
  Purpose: Provide minimal IAM roles and policies for automation and integrations 
  Features:
  - Role for CloudFront and WAF logging access
  - Role for ALB monitoring or service integration
  - Least privilege policies with scope to extend
  - Tagging for governance and audit
*/

# IAM Role for CloudFront Logging (assumes logging bucket access)
resource "aws_iam_role" "cloudfront_logging_role" {
  name = "${var.project_prefix}-cloudfront-logging-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "cloudfront_logging_policy" {
  name        = "${var.project_prefix}-cloudfront-logging-policy"
  description = "Policy allowing CloudFront to write logs to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetBucketAcl"
        ]
        Resource = [
          "${var.logging_bucket_arn}",
          "${var.logging_bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_logging_policy" {
  role       = aws_iam_role.cloudfront_logging_role.name
  policy_arn = aws_iam_policy.cloudfront_logging_policy.arn
}

# IAM Role for ALB monitoring (e.g. CloudWatch metrics)
resource "aws_iam_role" "alb_monitoring_role" {
  name = "${var.project_prefix}-alb-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "alb_monitoring_policy" {
  name        = "${var.project_prefix}-alb-monitoring-policy"
  description = "Policy to allow ALB monitoring and integration"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_alb_monitoring_policy" {
  role       = aws_iam_role.alb_monitoring_role.name
  policy_arn = aws_iam_policy.alb_monitoring_policy.arn
}
