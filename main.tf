locals {
  create_policy      = var.create_policy != null ? var.create_policy : var.role_arn == null
  dead_letter_config = var.dead_letter_target_arn != null ? { create : true } : {}
  environment        = var.environment != null ? { create : true } : {}
  execution_type     = var.subnet_ids == null ? "Basic" : "VPCAccess"
  filename           = var.filename != null ? var.filename : data.archive_file.dummy.output_path
  source_code_hash   = var.source_code_hash != null ? var.source_code_hash : var.filename != null ? filebase64sha256(var.filename) : null
  tracing_config     = var.tracing_config_mode != null ? { create : true } : {}
  ephemeral_storage  = var.ephemeral_storage_size != null ? { create : true } : {}
  vpc_config         = var.subnet_ids != null ? { create : true } : {}
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["edgelambda.amazonaws.com", "lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "default" {
  count                = local.create_policy ? 1 : 0
  name                 = join("-", compact([var.role_prefix, "LambdaRole", var.name]))
  assume_role_policy   = data.aws_iam_policy_document.default.json
  permissions_boundary = var.permissions_boundary
  tags                 = var.tags
}

resource "aws_iam_role_policy" "default" {
  count  = local.create_policy ? 1 : 0
  name   = "LambdaRole-${var.name}"
  role   = aws_iam_role.default[0].id
  policy = var.policy
}

resource "aws_cloudwatch_log_group" "default" {
  provider          = aws.lambda
  count             = var.cloudwatch_logs ? 1 : 0
  name              = "/aws/lambda/${var.name}"
  kms_key_id        = var.kms_key_arn
  retention_in_days = var.log_retention
  tags              = var.tags
}

resource "aws_iam_role_policy_attachment" "default" {
  provider   = aws.lambda
  count      = local.create_policy && var.cloudwatch_logs ? 1 : 0
  role       = aws_iam_role.default[0].id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambda${local.execution_type}ExecutionRole"
}

resource "aws_iam_role_policy_attachment" "enable_xray_daemon_write" {
  provider   = aws.lambda
  count      = local.create_policy && var.tracing_config_mode != null ? 1 : 0
  role       = aws_iam_role.default[0].id
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

data "aws_subnet" "selected" {
  provider = aws.lambda
  count    = var.subnet_ids != null ? 1 : 0
  id       = var.subnet_ids[0]
}

resource "aws_security_group" "default" {
  provider    = aws.lambda
  count       = var.subnet_ids != null ? 1 : 0
  name        = var.name
  description = "Security group for lambda ${var.name}"
  vpc_id      = data.aws_subnet.selected[0].vpc_id
  tags        = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_egress" {
  count             = var.subnet_ids != null && var.create_allow_all_egress_rule ? 1 : 0
  description       = "Allow all outbound traffic to any IPv4 address"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sg
  security_group_id = aws_security_group.default[0].id
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/dummy_payload.zip"

  source {
    content  = "dummy payload"
    filename = "dummy.txt"
  }
}

resource "aws_s3_object" "s3_dummy" {
  count  = var.s3_bucket != null && var.s3_key != null && var.create_s3_dummy_object ? 1 : 0
  bucket = var.s3_bucket
  key    = var.s3_key
  source = data.archive_file.dummy.output_path
  tags   = merge(var.tags, { "Lambda" = var.name })

  lifecycle {
    ignore_changes = [
      source
    ]
  }
}

resource "aws_lambda_function_event_invoke_config" "default" {
  count                  = var.retries != null ? 1 : 0
  function_name          = aws_lambda_function.default.function_name
  maximum_retry_attempts = var.retries
}

// tfsec:ignore:aws-lambda-enable-tracing
resource "aws_lambda_function" "default" {
  provider                       = aws.lambda
  architectures                  = [var.architecture]
  description                    = var.description
  filename                       = var.s3_bucket == null ? local.filename : null
  function_name                  = var.name
  handler                        = var.handler
  kms_key_arn                    = var.environment != null ? var.kms_key_arn : null
  layers                         = var.layers
  memory_size                    = var.memory_size
  publish                        = var.publish
  runtime                        = var.runtime
  reserved_concurrent_executions = var.reserved_concurrency
  role                           = var.role_arn != null ? var.role_arn : aws_iam_role.default[0].arn
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  s3_object_version              = var.s3_object_version
  source_code_hash               = var.s3_bucket == null ? local.source_code_hash : null
  timeout                        = var.timeout
  tags                           = var.tags

  dynamic "dead_letter_config" {
    for_each = local.dead_letter_config

    content {
      target_arn = var.dead_letter_target_arn
    }
  }

  dynamic "environment" {
    for_each = local.environment

    content {
      variables = var.environment
    }
  }

  dynamic "tracing_config" {
    for_each = local.tracing_config

    content {
      mode = var.tracing_config_mode
    }
  }

  dynamic "vpc_config" {
    for_each = local.vpc_config

    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.default[0].id]
    }
  }

  dynamic "ephemeral_storage" {
    for_each = local.ephemeral_storage

    content {
      size = var.ephemeral_storage_size
    }
  }
}
