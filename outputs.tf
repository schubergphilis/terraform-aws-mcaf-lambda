output "arn" {
  value       = aws_lambda_function.default.arn
  description = "ARN of the Lambda"
}

output "log_group_name" {
  value       = var.cloudwatch_logs ? aws_cloudwatch_log_group.default[0].name : ""
  description = "The Cloud Watch log group name"
}

output "name" {
  value       = aws_lambda_function.default.function_name
  description = "Function name of the Lambda"
}

output "qualified_arn" {
  value       = aws_lambda_function.default.qualified_arn
  description = "Qualified ARN of the Lambda"
}

output "security_group_id" {
  value       = var.subnet_ids != null ? aws_security_group.default[0].id : ""
  description = "If the Lambda is deployed into a VPC this will output the security group id"
}

output "version" {
  value       = aws_lambda_function.default.version
  description = "Latest published version of the Lambda function"
}
