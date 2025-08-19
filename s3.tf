
//creating first bucket (subdomain) 
resource "aws_s3_bucket" "first_bucket" {
  bucket = var.s3_bucket_name_1
  force_destroy = true

  tags = {
    Name        = "My website"
    Environment = "Dev"
  }
}

// disabling public access block for first bucket
resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  bucket = aws_s3_bucket.first_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
  depends_on = [aws_s3_bucket.first_bucket]
}

// creating second bucket for redirect (root domain)

resource "aws_s3_bucket" "second_bucket" {
  bucket = var.s3_bucket_name_2

  tags = {
    Name        = "My website"
    Environment = "Dev"
  }
}

// uploading index.html file to bucket 1
/*
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.first_bucket.id
  key    = var.html_file_name
  source = "${path.module}/${var.html_file_name}"
  content_type = "text/html"

 
}
*/




//redirecting  request form bucket 2 to bucket 1

resource "aws_s3_bucket_website_configuration" "redirect" {
  bucket = aws_s3_bucket.second_bucket.id

  redirect_all_requests_to {
    host_name = var.subdomain
    protocol  = "https"
  }
}






// policy to allow cloud front to do requests

resource "aws_s3_bucket_policy" "cloudfront_restrict" {
  bucket = aws_s3_bucket.first_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.allow_public_access]
  policy = jsonencode(
    {
        "Version": "2008-10-17",
        "Id": "PolicyForCloudFrontPrivateContent",
        "Statement": [
            {
                "Sid": "AllowCloudFrontServicePrincipal",
                "Effect": "Allow",
                "Principal": {
                    "Service": "cloudfront.amazonaws.com"
                },
                "Action": "s3:GetObject",
                "Resource": "${aws_s3_bucket.first_bucket.arn}/*",
                "Condition": {
                    "StringEquals": {
                      "AWS:SourceArn": "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
                    }                   
                }
            }
        ]
      }
  )

}



