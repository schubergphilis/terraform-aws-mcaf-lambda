# terraform-aws-mcaf-lambda

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | > 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | > 4.0.0 |
| <a name="provider_aws.lambda"></a> [aws.lambda](#provider\_aws.lambda) | > 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.enable_xray_daemon_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_s3_object.s3_dummy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [archive_file.dummy](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the lambda | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the bucket | `map(string)` | n/a | yes |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | Instruction set architecture of the Lambda function | `string` | `"x86_64"` | no |
| <a name="input_cloudwatch_logs"></a> [cloudwatch\_logs](#input\_cloudwatch\_logs) | Whether or not to configure a CloudWatch log group | `bool` | `true` | no |
| <a name="input_create_allow_all_egress_rule"></a> [create\_allow\_all\_egress\_rule](#input\_create\_allow\_all\_egress\_rule) | Controls whether an egress rule to any ipv4 address will be created when the lambda is configured to run in a VPC | `bool` | `false` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Overrule whether the Lambda role policy has to be created | `bool` | `null` | no |
| <a name="input_create_s3_dummy_object"></a> [create\_s3\_dummy\_object](#input\_create\_s3\_dummy\_object) | Whether or not to create a S3 dummy object | `bool` | `true` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | The ARN of an SNS topic or SQS queue to notify when an invocation fails | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the lambda | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | A map of environment variables to assign to the lambda | `map(string)` | `null` | no |
| <a name="input_ephemeral_storage_size"></a> [ephemeral\_storage\_size](#input\_ephemeral\_storage\_size) | The size of the Lambda function Ephemeral storage | `number` | `null` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | The path to the function's deployment package within the local filesystem | `string` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | The function entrypoint in your code | `string` | `"main.handler"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the KMS key used to encrypt the cloudwatch log group and environment variables | `string` | `null` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda layer ARNs to be used by the Lambda function | `list(string)` | `[]` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Number of days to retain log events in the specified log group | `number` | `14` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The memory size of the lambda | `number` | `null` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The permissions boundary to set on the role | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A valid lambda policy JSON document. Required if you don't specify a role\_arn | `string` | `null` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new lambda function version | `bool` | `false` | no |
| <a name="input_reserved_concurrency"></a> [reserved\_concurrency](#input\_reserved\_concurrency) | The amount of reserved concurrent executions for this lambda function | `number` | `null` | no |
| <a name="input_retries"></a> [retries](#input\_retries) | Maximum number of retries for the Lambda invocation | `number` | `null` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | An optional lambda execution role | `string` | `null` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The function runtime to use | `string` | `"python3.9"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | The S3 bucket location containing the function's deployment package | `string` | `null` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | The S3 key of an object containing the function's deployment package | `string` | `null` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | The object version containing the function's deployment package | `string` | `null` | no |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | Optional source code hash | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet ids where this lambda needs to run | `list(string)` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The timeout of the lambda | `number` | `5` | no |
| <a name="input_tracing_config_mode"></a> [tracing\_config\_mode](#input\_tracing\_config\_mode) | The lambda's AWS X-Ray tracing configuration | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the Lambda |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | Invoke ARN of the Lambda |
| <a name="output_name"></a> [name](#output\_name) | Function name of the Lambda |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | Qualified ARN of the Lambda |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the lambda execution role |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | If the Lambda is deployed into a VPC this will output the security group id |
| <a name="output_version"></a> [version](#output\_version) | Latest published version of the Lambda function |
<!-- END_TF_DOCS -->
