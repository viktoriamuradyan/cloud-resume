import json
import json
import boto3
import os

# environment variable from Terraform

ALLOWED_ORIGIN = os.environ["ALLOWED_ORIGIN"]

client = boto3.client('dynamodb')
def get_item():
    response = client.get_item(
        TableName="VisitorCounter",
        Key={
            "visitor_count": {
                "S": "visitor_count"

            }

        }

    )
    return response

def lambda_handler(event, context):

    http_method = event.get("httpMethod", "")

    if http_method == "OPTIONS":
        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": ALLOWED_ORIGIN,
                "Access-Control-Allow-Methods": "OPTIONS,POST,GET",
                "Access-Control-Allow-Headers": "Content-Type, Authorization, X-Amz-Date, X-Api-Key, X-Amz-Security-Token"
            },
            "body": ""
        }

   




    if http_method == "GET":
        response_before = get_item()

        if "Item" in response_before:
            item = response_before['Item']
            visitor_count = int(item["current_number"]["N"])

        return {
            "statusCode": 200,
            'headers': {
                'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Amz-Date, X-Api-Key, X-Amz-Security-Token',
                'Access-Control-Allow-Origin': 'https://www.viktoriamuradyan.com',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps({"visitor_count": visitor_count})
            }

    if http_method == "POST":
        response_after = client.update_item(
        
        TableName="VisitorCounter",
            Key={
                "visitor_count": {
                    "S": "visitor_count"

                }

            },
            UpdateExpression='ADD current_number :increment_value',
            ExpressionAttributeValues={
                ':increment_value': { "N": "1" }
            }


        )

        response_after = get_item()


        if "Item" in response_after:
            updated_item = response_after['Item']
            updated_visitor_count = int(updated_item["current_number"]["N"])

        return {
            "statusCode": 200,
            'headers': {
                'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Amz-Date, X-Api-Key, X-Amz-Security-Token',
                'Access-Control-Allow-Origin': 'https://www.viktoriamuradyan.com',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps({"visitor_count": updated_visitor_count})
            }
            