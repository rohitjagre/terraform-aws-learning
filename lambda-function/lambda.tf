provider "aws" {
  region  = "us-east-1"
  version = "~> 2.54"
}

resource "aws_iam_role" "terraform-lambda-role" {
  name = "terraform-lambda-function"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_lambda_function" "terraform-lambda-function" {
  function_name = "terraform-lambda-function"
  s3_bucket     = "terraform-lambda-function"
  s3_key        = "v1.0.0/lambda-function.zip"

  handler = "main.handler"
  runtime = "nodejs10.x"

  role = aws_iam_role.terraform-lambda-role.arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.terraform-lambda-function.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.gateway.execution_arn}/*/*"
}
