variable "region" {
  description = "region where the infrastructure will be deployed "
}

variable "html_file_name" {
    description = "html file name"
    
  
}


variable "s3_bucket_name_1" {
    description = "name for the first S3 bucket"
    type = string
  
}



variable "s3_bucket_name_2" {
    description = "name for the second S3 bucket"
    type = string
    
  
}

variable "root_domain" {
    type = string
    
}

variable "subdomain" {
    type = string
    
  
}

variable "hosted_zone" {
    description = "The name of the Route53 hosted zone"
    type = string
    
  
}

variable "fqdn" {
    description = "Fully Qualified Domain Name"
    type = string
  
}
