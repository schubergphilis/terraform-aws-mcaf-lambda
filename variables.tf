variable name {
  type        = string
  description = "The name of the lambda"
}

variable description {
  type        = string
  default     = ""
  description = "A description of the lambda"
}

variable handler {
  type        = string
  default     = "main.handler"
  description = "The function entrypoint in your code"
}

variable runtime {
  type        = string
  default     = "python3.7"
  description = "The function runtime to use"
}

variable policy {
  type        = string
  description = "A valid lambda policy JSON document"
}

variable principal_identifiers {
  type        = list(string)
  description = "Role principal identifiers"
  default     = ["lambda.amazonaws.com"]
}

variable cloudwatch_logs {
  type        = bool
  default     = true
  description = "Whether or not to configure a CloudWatch log group"
}

variable environment {
  type        = map(string)
  default     = {}
  description = "A map of environment variables to assign to the lambda"
}

variable timeout {
  type        = number
  default     = 5
  description = "The timeout of the lambda"
}

variable tags {
  type        = map(string)
  description = "A mapping of tags to assign to the bucket"
}
