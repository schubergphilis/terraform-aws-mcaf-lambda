output "arn" {
  value       = aws_lambda_function.default.arn
  description = "ARN of the Lambda"
}

output "name" {
  value       = aws_lambda_function.default.function_name
  description = "Function name of the Lambda"
}

output "invoke_arn" {
  value       = aws_lambda_function.default.invoke_arn
  description = "Invoke ARN of the Lambda"
}

output "qualified_arn" {
  value       = aws_lambda_function.default.qualified_arn
  description = "Qualified ARN of the Lambda"
}

output "role_arn" {
  value       = var.role_arn != null ? var.role_arn : aws_iam_role.default[0].arn
  description = "ARN of the lambda execution role"
}

output "security_group_id" {
  value       = var.subnet_ids != null ? aws_security_group.default[0].id : ""
  description = "If the Lambda is deployed into a VPC this will output the security group id"
}

output "version" {
  value       = aws_lambda_function.default.version
  description = "Latest published version of the Lambda function"
}
