output "arn" {
  value       = aws_lambda_function.default.arn
  description = "ARN of the lambda"
}

output "qualified_arn" {
  value       = aws_lambda_function.default.qualified_arn
  description = "Qualified ARN of the lambda"
}

output "security_group_id" {
  value       = var.subnet_ids != null ? aws_security_group.default[0].id : ""
  description = "If the Lambda is deployed into a VPC this will output the security group id"
}
