locals {
  create_event_invoke_config = var.retries != null || var.destination_on_failure != null || var.destination_on_success != null ? { create : true } : {}
  dead_letter_config         = var.dead_letter_target_arn != null ? { create : true } : {}
  environment                = var.environment != null ? { create : true } : {}
  ephemeral_storage          = var.ephemeral_storage_size != null ? { create : true } : {}
  execution_type             = var.subnet_ids == null ? "Basic" : "VPCAccess"
  filename                   = var.filename != null ? var.filename : data.archive_file.dummy.output_path
  source_code_hash           = var.source_code_hash != null ? var.source_code_hash : var.filename != null ? filebase64sha256(var.filename) : null
  tracing_config             = var.tracing_config_mode != null ? { create : true } : {}
  vpc_config                 = var.subnet_ids != null ? { create : true } : {}
}

module "lambda_role" {
  count = length(compact([var.role_arn])) == 0 ? 1 : 0

  source                = "github.com/schubergphilis/terraform-aws-mcaf-role?ref=v0.3.3"
  name                  = join("-", compact([var.role_prefix, "LambdaRole", var.name]))
  create_policy         = var.create_policy
  permissions_boundary  = var.permissions_boundary
  postfix               = false
  principal_identifiers = ["edgelambda.amazonaws.com", "lambda.amazonaws.com"]
  principal_type        = "Service"
  role_policy           = var.policy
  tags                  = var.tags

  policy_arns = compact([
    var.cloudwatch_logs ? "arn:aws:iam::aws:policy/service-role/AWSLambda${local.execution_type}ExecutionRole" : null,
    var.tracing_config_mode != null ? "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess" : null,
  ])
}

resource "aws_cloudwatch_log_group" "default" {
  count = var.cloudwatch_logs ? 1 : 0

  name              = "/aws/lambda/${var.name}"
  kms_key_id        = var.kms_key_arn
  retention_in_days = var.log_retention
  tags              = var.tags
}

data "aws_subnet" "selected" {
  count = var.subnet_ids != null ? 1 : 0

  id = var.subnet_ids[0]
}

resource "aws_security_group" "default" {
  #checkov:skip=CKV2_AWS_5: False positive finding, the security group is attached.
  count = var.subnet_ids != null && length(var.security_group_ids) == 0 ? 1 : 0

  name        = var.security_group_name_prefix == null ? var.name : null
  name_prefix = var.security_group_name_prefix != null ? var.security_group_name_prefix : null
  description = "Security group for lambda ${var.name}"
  vpc_id      = data.aws_subnet.selected[0].vpc_id
  tags        = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "default" {
  for_each = var.subnet_ids != null && length(var.security_group_ids) == 0 && length(var.security_group_egress_rules) != 0 ? { for v in var.security_group_egress_rules : v.description => v } : {}

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  security_group_id            = aws_security_group.default[0].id
  to_port                      = each.value.to_port
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
  count = var.s3_bucket != null && var.s3_key != null && var.create_s3_dummy_object ? 1 : 0

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
  for_each = local.create_event_invoke_config

  function_name          = aws_lambda_function.default.function_name
  maximum_retry_attempts = var.retries

  dynamic "destination_config" {
    for_each = var.destination_on_failure != null || var.destination_on_success != null ? { create : true } : {}

    content {
      dynamic "on_failure" {
        for_each = var.destination_on_failure != null ? { create : true } : {}

        content {
          destination = var.destination_on_failure
        }
      }

      dynamic "on_success" {
        for_each = var.destination_on_success != null ? { create : true } : {}

        content {
          destination = var.destination_on_success
        }
      }
    }
  }
}

// tfsec:ignore:aws-lambda-enable-tracing
resource "aws_lambda_function" "default" {
  architectures                  = [var.architecture]
  code_signing_config_arn        = var.code_signing_config_arn
  description                    = var.description
  filename                       = var.s3_bucket == null ? local.filename : null
  function_name                  = var.name
  handler                        = var.handler
  kms_key_arn                    = var.environment != null ? var.kms_key_arn : null
  layers                         = var.layers
  memory_size                    = var.memory_size
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrency
  role                           = length(compact([var.role_arn])) > 0 ? var.role_arn : module.lambda_role[0].arn
  runtime                        = var.runtime
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  s3_object_version              = var.s3_object_version
  source_code_hash               = local.source_code_hash
  tags                           = var.tags
  timeout                        = var.timeout

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
      security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : [aws_security_group.default[0].id]
    }
  }

  dynamic "ephemeral_storage" {
    for_each = local.ephemeral_storage

    content {
      size = var.ephemeral_storage_size
    }
  }
}
