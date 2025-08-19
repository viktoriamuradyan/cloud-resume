data "aws_acm_certificate" "issued" {
  provider = aws.us_east_1
  domain   = var.hosted_zone
  statuses = ["ISSUED"]
}




