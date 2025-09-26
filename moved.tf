moved {
  from = aws_iam_role_policy.default[0]
  to   = module.lambda_role[0].aws_iam_role_policy.default[0]
}

moved {
  from = aws_iam_role.default[0]
  to   = module.lambda_role[0].aws_iam_role.default
}

moved {
  from = aws_iam_role_policy_attachment.default[0]
  to   = module.lambda_role[0].aws_iam_role_policy_attachment.default["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
}

moved {
  from = aws_iam_role_policy_attachment.enable_xray_daemon_write[0]
  to   = module.lambda_role[0].aws_iam_role_policy_attachment.default["arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"]
}

moved {
  from = aws_cloudwatch_log_group.default[0]
  to   = aws_cloudwatch_log_group.default
}
