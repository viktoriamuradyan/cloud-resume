output "invoke_url" {
  value = "https://${aws_api_gateway_rest_api.visitor_count.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.visitor_count.stage_name}/${aws_api_gateway_resource.visitor_resource.path_part}"
}


