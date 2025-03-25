variable "architecture" {
  type        = string
  default     = "x86_64"
  description = "Instruction set architecture of the Lambda function"

  validation {
    condition     = contains(["arm64", "x86_64"], var.architecture)
    error_message = "Allowed values are \"arm64\" or \"x86_64\"."
  }
}

variable "cloudwatch_logs" {
  type        = bool
  default     = true
  description = "Whether or not to configure a CloudWatch log group"
}

variable "code_signing_config_arn" {
  type        = string
  default     = null
  description = "ARN for a Code Signing Configuration"
}

variable "create_s3_dummy_object" {
  type        = bool
  default     = true
  description = "Whether or not to create a S3 dummy object"
}

variable "dead_letter_target_arn" {
  type        = string
  default     = null
  description = "The ARN of an SNS topic or SQS queue to notify when an invocation fails"
}

variable "description" {
  type        = string
  default     = ""
  description = "A description of the lambda"
}

variable "destination_on_failure" {
  type        = string
  default     = null
  description = "ARN of the destination resource for failed asynchronous invocations"
}

variable "destination_on_success" {
  type        = string
  default     = null
  description = "ARN of the destination resource for successful asynchronous invocations"
}

variable "environment" {
  type        = map(string)
  default     = null
  description = "A map of environment variables to assign to the lambda"
}

variable "ephemeral_storage_size" {
  type        = number
  default     = null
  description = "The size of the Lambda function Ephemeral storage"
}

variable "execution_role" {
  type = object({
    additional_policy_arns = optional(set(string), [])
    create_policy          = optional(bool)
    name_prefix            = optional(string)
    path                   = optional(string, "/")
    permissions_boundary   = optional(string)
    policy                 = optional(string)
  })
  default     = {}
  description = "Configuration for lambda execution IAM role"

  validation {
    condition     = can(regex("^/.*?/$", var.execution_role.path)) || var.execution_role.path == "/"
    error_message = "The \"path\" must start and end with \"/\" or be \"/\"."
  }
}

variable "execution_role_custom" {
  type = object({
    arn = string
  })
  default     = null
  description = "Optional existing IAM role for Lambda execution. Overrides the role configured in the execution_role variable."

  validation {
    condition     = var.execution_role_custom == null || can(regex("^arn:aws:iam::[0-9]{12}:(role)/.+$", var.execution_role_custom.arn))
    error_message = "If provided, \"arn\" must match an AWS Principal ARN"
  }
}

variable "filename" {
  type        = string
  default     = null
  description = "The path to the function's deployment package within the local filesystem"
}

variable "handler" {
  type        = string
  default     = "main.handler"
  description = "The function entrypoint in your code"
}

variable "image_config" {
  type = object({
    command           = optional(list(string), [])
    entry_point       = optional(list(string), [])
    uri               = optional(string)
    working_directory = optional(string)
  })
  default     = null
  description = "Container image configuration values. The ECR image URI must be a private ECR URI."

  validation {
    condition     = var.image_config == null || can(regex("^[0-9]{12}.dkr.ecr.[a-zA-Z0-9-]+.amazonaws.com/.+$", var.image_config.uri))
    error_message = "The \"uri\" be a valid private ECR URI."
  }
}

variable "kms_key_arn" {
  type        = string
  default     = null
  description = "The ARN of the KMS key used to encrypt the cloudwatch log group and environment variables"
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "List of Lambda layer ARNs to be used by the Lambda function"
}

variable "log_retention" {
  type        = number
  default     = 365
  description = "Number of days to retain log events in the specified log group"
}

variable "memory_size" {
  type        = number
  default     = null
  description = "The memory size of the lambda"
}

variable "name" {
  type        = string
  description = "The name of the lambda"
}

variable "package_type" {
  type        = string
  default     = "Zip"
  description = "The Lambda deployment package type."

  validation {
    condition     = contains(["Image", "Zip"], var.package_type)
    error_message = "Allowed values are \"Image\" or \"Zip\"."
  }
}

variable "publish" {
  type        = bool
  default     = false
  description = "Whether to publish creation/change as new lambda function version"
}

variable "reserved_concurrency" {
  type        = number
  default     = null
  description = "The amount of reserved concurrent executions for this lambda function"
}

variable "retries" {
  type        = number
  default     = null
  description = "Maximum number of retries for the Lambda invocation"
}

variable "runtime" {
  type        = string
  default     = "python3.13"
  description = "The function runtime to use"
}

variable "s3_bucket" {
  type        = string
  default     = null
  description = "The S3 bucket location containing the function's deployment package"
}

variable "s3_key" {
  type        = string
  default     = null
  description = "The S3 key of an object containing the function's deployment package"
}

variable "s3_object_version" {
  type        = string
  default     = null
  description = "The object version containing the function's deployment package"
}

variable "security_group_egress_rules" {
  type = list(object({
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = string
    from_port                    = optional(number, 0)
    ip_protocol                  = optional(string, "-1")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    to_port                      = optional(number, 0)
  }))
  default     = []
  description = "Security Group egress rules"

  validation {
    condition     = alltrue([for o in var.security_group_egress_rules : (o.cidr_ipv4 != null || o.cidr_ipv6 != null || o.prefix_list_id != null || o.referenced_security_group_id != null)])
    error_message = "Although \"cidr_ipv4\", \"cidr_ipv6\", \"prefix_list_id\", and \"referenced_security_group_id\" are all marked as optional, you must provide one of them in order to configure the destination of the traffic."
  }
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "The security group(s) for running the Lambda within the VPC. If not specified a minimal default SG will be created"
}

variable "security_group_name_prefix" {
  type        = string
  default     = null
  description = "An optional prefix to create a unique name of the security group. If not provided `var.name` will be used"
}

variable "source_code_hash" {
  type        = string
  default     = null
  description = "Optional source code hash"
}

variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "The subnet ids where this lambda needs to run"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the bucket"
}

variable "timeout" {
  type        = number
  default     = 5
  description = "The timeout of the lambda"
}

variable "tracing_config_mode" {
  type        = string
  default     = null
  description = "The lambda's AWS X-Ray tracing configuration"

  validation {
    condition     = var.tracing_config_mode == null || var.tracing_config_mode == "Active" || var.tracing_config_mode == "PassThrough"
    error_message = "If provided, allowed values are \"Active\" or \"PassThrough\"."
  }
}
