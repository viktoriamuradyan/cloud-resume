data "aws_route53_zone" "main" {
  name         = var.hosted_zone
  private_zone = false
}

//root domain record
resource "aws_route53_record" "root_domain" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.root_domain
  type    = "A"
  
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

// subdomain record
resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.subdomain
  type    = "A"
  
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution_redirect.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution_redirect.hosted_zone_id
    evaluate_target_health = false
  }
}