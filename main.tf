locals {
  environment = var.environment != null ? { create : true } : {}
  filename    = var.filename != null ? var.filename : data.archive_file.dummy.output_path
  region      = var.region != null ? var.region : data.aws_region.current.name
  vpc_config  = var.subnet_ids != null ? { create : true } : {}

  assume_role = var.assume_role ? { create : true } : {}
  assume_role_arn = format(
    "arn:aws:iam::%s:role/%s",
    data.aws_caller_identity.current.account_id,
    split("/", data.aws_caller_identity.current.arn)[1]
  )
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_subnet" "default" {
  provider = aws.lambda
  count    = var.subnet_ids != null ? 1 : 0
  id       = var.subnet_ids[0]
}

provider "aws" {
  alias  = "lambda"
  region = local.region

  dynamic assume_role {
    for_each = local.assume_role

    content {
      role_arn = local.assume_role_arn
    }
  }
}

module "lambda_role" {
  source                = "github.com/schubergphilis/terraform-aws-mcaf-role?ref=v0.1.2"
  name                  = "LambdaRole-${var.name}"
  principal_type        = "Service"
  principal_identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
  policy                = var.policy
  tags                  = var.tags
}

resource "aws_cloudwatch_log_group" "default" {
  count             = var.cloudwatch_logs ? 1 : 0
  provider          = aws.lambda
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 14
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.cloudwatch_logs ? 1 : 0
  provider   = aws.lambda
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

resource "aws_security_group" "default" {
  provider    = aws.lambda
  count       = var.subnet_ids != null ? 1 : 0
  name        = var.name
  description = "Security group for lambda ${var.name}"
  vpc_id      = data.aws_subnet.default[0].vpc_id
  tags        = var.tags

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_function" "default" {
  provider      = aws.lambda
  function_name = var.name
  description   = var.description
  filename      = local.filename
  handler       = var.handler
  runtime       = var.runtime
  role          = module.lambda_role.arn
  publish       = var.publish
  tags          = var.tags
  timeout       = var.timeout

  dynamic vpc_config {
    for_each = local.vpc_config
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.default[0].id]
    }
  }

  dynamic environment {
    for_each = local.environment

    content {
      variables = var.environment
    }
  }
}
