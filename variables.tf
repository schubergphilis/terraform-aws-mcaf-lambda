variable "name" {
  type        = string
  description = "The name of the lambda"
}

variable "description" {
  type        = string
  default     = ""
  description = "A description of the lambda"
}

variable "assume_role" {
  type        = bool
  default     = false
  description = "Whether or not to dynamically re-assume the role using the current account"
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

variable "runtime" {
  type        = string
  default     = "python3.7"
  description = "The function runtime to use"
}

variable "policy" {
  type        = string
  description = "A valid lambda policy JSON document"
}

variable "publish" {
  type        = bool
  default     = false
  description = "Whether to publish creation/change as new lambda function version"
}

variable "region" {
  type        = string
  default     = null
  description = "The region this lambda should reside in, defaults to the region used by the callee"
}

variable "cloudwatch_logs" {
  type        = bool
  default     = true
  description = "Whether or not to configure a CloudWatch log group"
}

variable "environment" {
  type        = map(string)
  default     = null
  description = "A map of environment variables to assign to the lambda"
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
