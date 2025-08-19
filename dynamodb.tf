resource "aws_dynamodb_table" "visitor_count" {
  name           = "VisitorCounter"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "visitor_count"
  

  attribute {
    name = "visitor_count"
    type = "S"
  }

 
  

  

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}


resource "aws_dynamodb_table_item" "visitor_item" {
  table_name = aws_dynamodb_table.visitor_count.name
  hash_key   = aws_dynamodb_table.visitor_count.hash_key

  item = jsonencode({
    visitor_count = {
      S = "visitor_count"  
    }
    current_number = {
      N = "0"  #
    }
  })

  lifecycle {
    ignore_changes = [item]
  }
}