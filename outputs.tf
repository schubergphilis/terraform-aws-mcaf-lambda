output "arn" {
  value       = aws_lambda_function.default.arn
  description = "ARN of the lambda"
}

output "qualified_arn" {
  value       = aws_lambda_function.default.qualified_arn
  description = "Qualified ARN of the lambda"
}
