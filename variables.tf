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

variable "create_policy" {
  type        = bool
  default     = null
  description = "Overrule whether the Lambda role policy has to be created"
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

variable "permissions_boundary" {
  type        = string
  default     = null
  description = "The permissions boundary to set on the role"
}

variable "policy" {
  type        = string
  default     = null
  description = "A valid lambda policy JSON document. Required if you don't specify a role_arn"
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

variable "role_arn" {
  type        = string
  default     = null
  description = "An optional lambda execution role"
}

variable "role_prefix" {
  type        = string
  description = "Default prefix for the role"
  default     = null
}

variable "runtime" {
  type        = string
  default     = "python3.10"
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
}
