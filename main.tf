locals {
  role_name = "LambdaRole-${var.name}"
}

module "lambda_role" {
  source                = "github.com/schubergphilis/terraform-aws-mcaf-role?ref=v0.1.2"
  name                  = local.role_name
  principal_type        = "Service"
  principal_identifiers = ["lambda.amazonaws.com"]
  policy                = var.policy
  tags                  = var.tags
}

resource "aws_cloudwatch_log_group" "default" {
  count             = var.cloudwatch_logs ? 1 : 0
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 14
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.cloudwatch_logs ? 1 : 0
  role       = module.lambda_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/dummy_payload.zip"

  source {
    content  = "dummy payload"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "default" {
  function_name = var.name
  description   = var.description
  filename      = data.archive_file.dummy.output_path
  handler       = var.handler
  runtime       = var.runtime
  role          = module.lambda_role.arn
  tags          = var.tags

  environment {
    variables = var.environment
  }
}
