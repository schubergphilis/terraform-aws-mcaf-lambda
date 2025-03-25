# terraform-aws-mcaf-lambda

Terraform module to create an AWS Lambda function.

> [!TIP]
> We do not pin modules to versions in our examples. We highly recommend that in your code you pin the version to the exact version you are using so that your infrastructure remains stable.

> [!IMPORTANT]
> Exactly one of `var.filename`, `var.image_config.uri`, or `var.s3_bucket` must be specified when using the module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.76.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.0.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.76.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_role"></a> [lambda\_role](#module\_lambda\_role) | schubergphilis/mcaf-role/aws | ~> 0.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lambda_function.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_s3_object.s3_dummy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [archive_file.dummy](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the lambda | `string` | n/a | yes |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | Instruction set architecture of the Lambda function | `string` | `"x86_64"` | no |
| <a name="input_cloudwatch_logs"></a> [cloudwatch\_logs](#input\_cloudwatch\_logs) | Whether or not to configure a CloudWatch log group | `bool` | `true` | no |
| <a name="input_code_signing_config_arn"></a> [code\_signing\_config\_arn](#input\_code\_signing\_config\_arn) | ARN for a Code Signing Configuration | `string` | `null` | no |
| <a name="input_create_s3_dummy_object"></a> [create\_s3\_dummy\_object](#input\_create\_s3\_dummy\_object) | Whether or not to create a S3 dummy object | `bool` | `true` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | The ARN of an SNS topic or SQS queue to notify when an invocation fails | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the lambda | `string` | `""` | no |
| <a name="input_destination_on_failure"></a> [destination\_on\_failure](#input\_destination\_on\_failure) | ARN of the destination resource for failed asynchronous invocations | `string` | `null` | no |
| <a name="input_destination_on_success"></a> [destination\_on\_success](#input\_destination\_on\_success) | ARN of the destination resource for successful asynchronous invocations | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | A map of environment variables to assign to the lambda | `map(string)` | `null` | no |
| <a name="input_ephemeral_storage_size"></a> [ephemeral\_storage\_size](#input\_ephemeral\_storage\_size) | The size of the Lambda function Ephemeral storage | `number` | `null` | no |
| <a name="input_execution_role"></a> [execution\_role](#input\_execution\_role) | Configuration for lambda execution IAM role | <pre>object({<br/>    additional_policy_arns = optional(set(string), [])<br/>    create_policy          = optional(bool)<br/>    name_prefix            = optional(string)<br/>    path                   = optional(string, "/")<br/>    permissions_boundary   = optional(string)<br/>    policy                 = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_execution_role_custom"></a> [execution\_role\_custom](#input\_execution\_role\_custom) | Optional existing IAM role for Lambda execution. Overrides the role configured in the execution\_role variable. | <pre>object({<br/>    arn = string<br/>  })</pre> | `null` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | The path to the function's deployment package within the local filesystem | `string` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | The function entrypoint in your code | `string` | `"main.handler"` | no |
| <a name="input_image_config"></a> [image\_config](#input\_image\_config) | Container image configuration values. The ECR image URI must be a private ECR URI. | <pre>object({<br/>    command           = optional(list(string), [])<br/>    entry_point       = optional(list(string), [])<br/>    uri               = optional(string)<br/>    working_directory = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the KMS key used to encrypt the cloudwatch log group and environment variables | `string` | `null` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda layer ARNs to be used by the Lambda function | `list(string)` | `[]` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Number of days to retain log events in the specified log group | `number` | `365` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The memory size of the lambda | `number` | `null` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | The Lambda deployment package type. | `string` | `"Zip"` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new lambda function version | `bool` | `false` | no |
| <a name="input_reserved_concurrency"></a> [reserved\_concurrency](#input\_reserved\_concurrency) | The amount of reserved concurrent executions for this lambda function | `number` | `null` | no |
| <a name="input_retries"></a> [retries](#input\_retries) | Maximum number of retries for the Lambda invocation | `number` | `null` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The function runtime to use | `string` | `"python3.13"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | The S3 bucket location containing the function's deployment package | `string` | `null` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | The S3 key of an object containing the function's deployment package | `string` | `null` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | The object version containing the function's deployment package | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Security Group egress rules | <pre>list(object({<br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = string<br/>    from_port                    = optional(number, 0)<br/>    ip_protocol                  = optional(string, "-1")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    to_port                      = optional(number, 0)<br/>  }))</pre> | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | The security group(s) for running the Lambda within the VPC. If not specified a minimal default SG will be created | `list(string)` | `[]` | no |
| <a name="input_security_group_name_prefix"></a> [security\_group\_name\_prefix](#input\_security\_group\_name\_prefix) | An optional prefix to create a unique name of the security group. If not provided `var.name` will be used | `string` | `null` | no |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | Optional source code hash | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet ids where this lambda needs to run | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the bucket | `map(string)` | `{}` | no |
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
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of the lambda execution role |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | If the Lambda is deployed into a VPC this will output the genetered security group id (if no security groups are specified) |
| <a name="output_version"></a> [version](#output\_version) | Latest published version of the Lambda function |
<!-- END_TF_DOCS -->

## Licensing

100% Open Source and licensed under the Apache License Version 2.0. See [LICENSE](https://github.com/schubergphilis/terraform-aws-mcaf-lambda/blob/master/LICENSE) for full details.
