# Route 53
data "aws_route53_zone" "workout11" {
  name = "workout11.com"
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