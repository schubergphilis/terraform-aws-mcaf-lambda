variable "name" {
  type        = string
  description = "The name of the lambda"
}

variable "description" {
  type        = string
  default     = ""
  description = "A description of the lambda"
}

variable "cloudwatch_logs" {
  type        = bool
  default     = true
  description = "Whether or not to configure a CloudWatch log group"
}

variable "create_policy" {
  type        = bool
  default     = null
  description = "Overrule whether the Lambda role policy has to be created"
}

variable "environment" {
  type        = map(string)
  default     = null
  description = "A map of environment variables to assign to the lambda"
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
  description = "The ARN for the KMS key used to encrypt the environment variables"
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "List of Lambda layer ARNs to be used by the Lambda function"
}

variable "log_retention" {
  type        = number
  default     = 14
  description = "Number of days to retain log events in the specified log group"
}

variable "memory_size" {
  type        = number
  default     = null
  description = "The memory size of the lambda"
}

variable "runtime" {
  type        = string
  default     = "python3.7"
  description = "The function runtime to use"
}

variable "reserved_concurrency" {
  type        = number
  default     = null
  description = "The amount of reserved concurrent executions for this lambda function"
}

variable "role_arn" {
  type        = string
  default     = null
  description = "An optional lambda execution role"
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

variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "The subnet ids where this lambda needs to run"
}

variable "timeout" {
  type        = number
  default     = 5
  description = "The timeout of the lambda"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the bucket"
}

variable "retries" {
  type        = number
  default     = null
  description = "Number of maximum retries for the lambda"
}
