variable "name" {
  type        = string
  description = "The name of the lambda"
}

variable "description" {
  type        = string
  default     = ""
  description = "A description of the lambda"
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

variable "cloudwatch_logs" {
  type        = bool
  default     = true
  description = "Whether or not to configure a CloudWatch log group"
}

variable "environment" {
  type        = map(string)
  default     = {}
  description = "A map of environment variables to assign to the lambda"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the bucket"
}
