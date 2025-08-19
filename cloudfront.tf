resource "aws_cloudfront_origin_access_control" "s3_origin" {
  name                              = "s3_origin"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

locals {
  s3_origin_id = "myS3Origin"
}



resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.first_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_origin.id
    origin_id                = local.s3_origin_id
  }
    aliases = ["www.viktoriamuradyan.com"]

    enabled             = true
    default_root_object = "index.html"


  

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }


  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.issued.arn
    ssl_support_method       = "sni-only"
}
}


//second cloudfront distribution for the second redirect bucket

locals {
  s3_origin_redirect_id = "myS3Origin-redirect"
}

resource "aws_cloudfront_distribution" "s3_distribution_redirect" {
  origin {
    domain_name              = aws_s3_bucket_website_configuration.redirect.website_endpoint
    origin_id                = local.s3_origin_redirect_id

    custom_origin_config {
    origin_protocol_policy = "http-only"
    http_port              = 80
    https_port             = 443
    origin_ssl_protocols   = ["TLSv1.2"]
  }
  }

    aliases = ["viktoriamuradyan.com"]

    enabled             = true
   


  

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_redirect_id

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }


  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.issued.arn
    ssl_support_method       = "sni-only"
}
}





