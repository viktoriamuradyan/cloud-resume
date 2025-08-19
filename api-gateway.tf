


resource "aws_api_gateway_rest_api" "visitor_count" {
  name = "VisitorCounterAPI"
}

resource "aws_api_gateway_resource" "visitor_resource" {
  parent_id   = aws_api_gateway_rest_api.visitor_count.root_resource_id
  path_part   = "visitor_count"
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
}

// creating POST method
resource "aws_api_gateway_method" "post_method" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.visitor_resource.id
  rest_api_id   = aws_api_gateway_rest_api.visitor_count.id
}



resource "aws_api_gateway_integration" "lambda_proxy_post" {
  http_method = aws_api_gateway_method.post_method.http_method
  resource_id = aws_api_gateway_resource.visitor_resource.id
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
  type        = "AWS_PROXY"
  integration_http_method = "POST"  
  uri = aws_lambda_function.visitor_count.invoke_arn
}

resource "aws_api_gateway_method_response" "post_response_200" {
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
  resource_id = aws_api_gateway_resource.visitor_resource.id
  http_method = aws_api_gateway_method.post_method.http_method
  status_code = "200"

  response_parameters = {

    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"  # <--- Set application/json to use Empty model
  }
}


//creating GET method

resource "aws_api_gateway_method" "get_method" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.visitor_resource.id
  rest_api_id   = aws_api_gateway_rest_api.visitor_count.id
}



resource "aws_api_gateway_integration" "lambda_proxy_get" {
  http_method = aws_api_gateway_method.get_method.http_method
  resource_id = aws_api_gateway_resource.visitor_resource.id
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
  type        = "AWS_PROXY"
  integration_http_method = "POST"  
  uri = aws_lambda_function.visitor_count.invoke_arn
}

resource "aws_api_gateway_method_response" "get_response_200" {
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
  resource_id = aws_api_gateway_resource.visitor_resource.id
  http_method = aws_api_gateway_method.get_method.http_method
  status_code = "200"

  response_parameters = {

    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"  
  }
}

// lambda permission

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.visitor_count.function_name
  principal     = "apigateway.amazonaws.com"

  
source_arn = "arn:aws:execute-api:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.visitor_count.id}/*/*"

}


//creating OPTIONS method
resource "aws_api_gateway_method" "options_method" {
  authorization = "NONE"
  http_method   = "OPTIONS"
  resource_id   = aws_api_gateway_resource.visitor_resource.id
  rest_api_id   = aws_api_gateway_rest_api.visitor_count.id
}



resource "aws_api_gateway_integration" "lambda_proxy_options" {
  http_method = aws_api_gateway_method.options_method.http_method
  resource_id = aws_api_gateway_resource.visitor_resource.id
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  } 
 
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
  resource_id = aws_api_gateway_resource.visitor_resource.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"  # <--- Set application/json to use Empty model
  }
}


resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id
  resource_id = aws_api_gateway_resource.visitor_resource.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST'"
    "method.response.header.Access-Control-Allow-Origin"  = "'${var.fqdn}'"
  }
}



//

//api gateway deployment

resource "aws_api_gateway_deployment" "visitor_count" {
  rest_api_id = aws_api_gateway_rest_api.visitor_count.id

  
   triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.get_method.id,
      aws_api_gateway_method.post_method.id,
      aws_api_gateway_method.options_method.id,
      aws_api_gateway_method_response.get_response_200.id,
      aws_api_gateway_method_response.post_response_200.id,
      aws_api_gateway_method_response.response_200.id,
      aws_api_gateway_integration.lambda_proxy_get.id,
      aws_api_gateway_integration.lambda_proxy_post.id,
      aws_api_gateway_integration.lambda_proxy_options.id,
      aws_api_gateway_integration_response.integration_response.id
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "visitor_count" {
  deployment_id = aws_api_gateway_deployment.visitor_count.id
  rest_api_id   = aws_api_gateway_rest_api.visitor_count.id
  stage_name    = "dev"
}