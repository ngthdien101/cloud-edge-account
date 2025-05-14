/*
  Module: Redirect Service (ALB)
  Purpose: Create an ALB that redirects HTTP traffic to the HTTPS version or to another domain.
  Features:
  - ALB with listener on HTTP (80)
  - Redirect rules to HTTPS or specified domain
  - Security group for ALB allowing inbound HTTP/HTTPS
  - Tags for resource management and billing
*/

resource "aws_security_group" "alb_sg" {
  name        = "${var.redirect_domain}-alb-sg"
  description = "Security group for ALB redirect service"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS inbound"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_lb" "redirect_alb" {
  name               = "${var.redirect_domain}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.redirect_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

// Optional HTTPS listener for future expansion (requires certificate ARN)
/*
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.redirect_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "HTTPS Redirect Service"
      status_code  = "200"
    }
  }
}
*/
