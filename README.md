# terraform-aws-mcaf-lambda

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| aws.lambda | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the lambda | `string` | n/a | yes |
| tags | A mapping of tags to assign to the bucket | `map(string)` | n/a | yes |
| cloudwatch\_logs | Whether or not to configure a CloudWatch log group | `bool` | `true` | no |
| create\_policy | Overrule whether the Lambda role policy has to be created | `bool` | `null` | no |
| description | A description of the lambda | `string` | `""` | no |
| environment | A map of environment variables to assign to the lambda | `map(string)` | `null` | no |
| filename | The path to the function's deployment package within the local filesystem | `string` | `null` | no |
| handler | The function entrypoint in your code | `string` | `"main.handler"` | no |
| kms\_key\_arn | The ARN for the KMS key used to encrypt the environment variables | `string` | `null` | no |
| layers | List of Lambda layer ARNs to be used by the Lambda function | `list(string)` | `[]` | no |
| log\_retention | Number of days to retain log events in the specified log group | `number` | `14` | no |
| memory\_size | The memory size of the lambda | `number` | `null` | no |
| policy | A valid lambda policy JSON document. Required if you don't specify a role\_arn | `string` | `null` | no |
| publish | Whether to publish creation/change as new lambda function version | `bool` | `false` | no |
| reserved\_concurrency | The amount of reserved concurrent executions for this lambda function | `number` | `null` | no |
| retries | Maximum number of retries for the Lambda invocation | `number` | `null` | no |
| role\_arn | An optional lambda execution role | `string` | `null` | no |
| runtime | The function runtime to use | `string` | `"python3.7"` | no |
| s3\_bucket | The S3 bucket location containing the function's deployment package | `string` | `null` | no |
| s3\_key | The S3 key of an object containing the function's deployment package | `string` | `null` | no |
| s3\_object\_version | The object version containing the function's deployment package | `string` | `null` | no |
| subnet\_ids | The subnet ids where this lambda needs to run | `list(string)` | `null` | no |
| timeout | The timeout of the lambda | `number` | `5` | no |
| tracing\_config\_mode | The lambda's AWS X-Ray tracing configuration | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the Lambda |
| log\_group\_name | The Cloud Watch log group name |
| name | Function name of the Lambda |
| qualified\_arn | Qualified ARN of the Lambda |
| security\_group\_id | If the Lambda is deployed into a VPC this will output the security group id |
| version | Latest published version of the Lambda function |

<!--- END_TF_DOCS --->
