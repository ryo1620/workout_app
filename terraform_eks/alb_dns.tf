# security group
module "http_sg" {
  source      = "./security_group"
  name        = "http-sg"
  tag_name    = "http-sg"
  vpc_id      = aws_vpc.workout11.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source      = "./security_group"
  name        = "https-sg"
  tag_name    = "https-sg"
  vpc_id      = aws_vpc.workout11.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "http_redirect_sg" {
  source      = "./security_group"
  name        = "http-redirect-sg"
  tag_name    = "http-redirect-sg"
  vpc_id      = aws_vpc.workout11.id
  port        = 8080
  cidr_blocks = ["0.0.0.0/0"]
}

# ALB
resource "aws_lb" "workout11" {
  name                       = "${var.app_name}-ALB"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = true

  subnets = [
  aws_subnet.public_0.id,
  aws_subnet.public_1.id,
  ]

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    enabled = true
  }

  security_groups = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id,
    module.http_redirect_sg.security_group_id,
  ]
}

output "alb_dns_name" {
  value = aws_lb.workout11.dns_name
}

# Route 53
data "aws_route53_zone" "workout11" {
  name = "workout11.com"
}

resource "aws_route53_record" "workout11" {
  zone_id = data.aws_route53_zone.workout11.zone_id
  name    = data.aws_route53_zone.workout11.name
  type    = "A"

  alias {
    name                   = aws_lb.workout11.dns_name
    zone_id                = aws_lb.workout11.zone_id
    evaluate_target_health = true
  }
}

# SSL証明書
resource "aws_acm_certificate" "workout11" {
  domain_name               = data.aws_route53_zone.workout11.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# SSL証明書の検証
resource "aws_route53_record" "workout11_certificate" {
  name    = aws_acm_certificate.workout11.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.workout11.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.workout11.domain_validation_options[0].resource_record_value]
  zone_id = data.aws_route53_zone.workout11.id
  ttl     = 60
}

# SSL証明書の検証完了まで待機
resource "aws_acm_certificate_validation" "workout11" {
  certificate_arn         = aws_acm_certificate.workout11.arn
  validation_record_fqdns = [aws_route53_record.workout11_certificate.fqdn]
}

# ALB listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.workout11.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTP』です"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.workout11.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.workout11.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTPS』です"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.workout11.arn
  port     = "8080"
  protocol = "HTTP"

  default_action {
  type = "redirect"

  redirect {
    port        = "443"
    protocol    = "HTTPS"
    status_code = "HTTP_301"
    }
  }
}

# Forwarding
resource "aws_lb_target_group" "workout11" {
  name                 = "${var.app_name}-Tgroup"
  vpc_id               = aws_vpc.workout11.id
  target_type          = "ip"
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.workout11]
}

resource "aws_lb_listener_rule" "workout11" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.workout11.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}