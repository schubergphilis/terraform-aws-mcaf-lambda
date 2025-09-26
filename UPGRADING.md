# Upgrading Notes

This document captures required refactoring on your part when upgrading to a module version that contains breaking changes.

## Upgrading to v3.0.0

### Key Changes

- This module now requires a minimum AWS provider version of 6.0 to support the `region` parameter. If you are using multiple AWS provider blocks, please read [migrating from multiple provider configurations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/enhanced-region-support#migrating-from-multiple-provider-configurations).
- The Cloudwatch log group is now always created for the Lambda function to prevent the log group from being automatically created if the Lambda function is invoked before the log group is created by Terraform.

#### Variables

The following variable have been removed:

* `cloudwatch_logs`. This variable is not deemed necessary anymore, a CloudWatch log group will always be created for the Lambda function.

## Upgrading to v2.0.0

### Variables (v2.0.0)

The following variables have been replaced:

* `permissions_boundary` → `execution_role.permissions_boundary`
* `policy` → `execution_role.policy`
* `role_arn` → `execution_role_custom.arn`
* `role_prefix` → `execution_role.name_prefix`

The following variables have been introduced:

* `execution_role.additional_policy_arns`. Add additional policy arns to the execution role.
* `execution_role.path`. Customizable role path.

The following variables have been removed:

* `create_policy`. This variable is not deemed necessary anymore, creating the policy is controlled by providing an `execution_role.policy`.

The following variable defaults have been modified:

* `runtime` → default: `python3.13` (previous: `python3.10`).

## Upgrading to v1.0.0

### Behaviour (v1.0.0)

The need to provide a `providers = { aws.lambda = aws }` argument has been removed. When using v1.0.0 or higher the provider will simply default to aws and if a different provider is needed, one can be provisioned by passing down `providers = { aws = aws.lambda }`.

### Variables (v1.0.0)

The following variable defaults have been modified:

* `log_retention` → default: `365` (previous: `14`). In order to comply with AWS Security Hub control CloudWatch.16.
* `runtime` → default: `python3.10` (previous: `python3.9`).
* `tags` → default: `{}` (previous: ``). We recommend to set tags on the specified AWS provider.
