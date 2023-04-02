resource "aws_route53_zone" "yjbae" {
  name          = "yjbae.com"
  force_destroy = true
}

resource "aws_route53_record" "yjbae_record" {
  zone_id = aws_route53_zone.yjbae.zone_id
  name    = "www.yjbae.com"
  type    = "A"
  ttl     = 300
  records = [aws_lb.nginx-alb.dns_name]
}

resource "aws_route53_record" "alias_route53_record" {
  zone_id = aws_route53_zone.yjbae.zone_id
  name    = "yjbae.com"
  type    = "A"

  alias {
    name                   = aws_lb.nginx-alb.dns_name
    zone_id                = aws_lb.nginx-alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "cert" {
  provider                  = aws.us-east-1
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
  tags                      = local.tags
}

resource "aws_route53_record" "certvalidation" {
  for_each = {
    for d in aws_acm_certificate.cert.domain_validation_options : d.domain_name => {
      name   = d.resource_record_name
      record = d.resource_record_value
      type   = d.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.domain.zone_id
}

resource "aws_acm_certificate_validation" "certvalidation" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.certvalidation : r.fqdn]
}

resource "aws_route53_record" "websiteurl" {
  name    = var.endpoint
  zone_id = data.aws_route53_zone.domain.zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}