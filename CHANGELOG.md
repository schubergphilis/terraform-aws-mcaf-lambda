# Changelog

All notable changes to this project will automatically be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v2.1.1 - 2025-03-25

### What's Changed

#### 🐛 Bug Fixes

* fix: create_policy is required in some situations (#86) @jverhoeks

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v2.1.0...v2.1.1

## v2.1.0 - 2025-03-13

### What's Changed

#### 🚀 Features

* feat: updates examples, role -> new_role, adds existing_role + runtime default value of python3.13 requires provider bump (#85) @stefanwb

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v2.0.0...v2.1.0

## v2.0.0 - 2024-12-30

### What's Changed

#### 🚀 Features

* feature: add support for providing an lambda image & update default runtime (#80) @marwinbaumannsbp
* breaking: Update all execution role related variables (#79) @marlonparmentier

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.4.1...v2.0.0

## v1.4.1 - 2024-07-02

### What's Changed

#### 🐛 Bug Fixes

* fix: Fix the check on given RoleArn (#77) @fatbasstard

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.4.0...v1.4.1

## v1.4.0 - 2024-06-11

### What's Changed

#### 🚀 Features

* feature: Refactor role and policy (#75) @fatbasstard

#### 🐛 Bug Fixes

* bug: Refactor role_arn variable to list of strings to cope with 'Invalid count' error (#76) @stefanwb

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.3.0...v1.4.0

## v1.3.0 - 2024-04-16

### What's Changed

#### 🚀 Features

* feature: Add role name to output of Lambda when this is available (#73) @stefanwb

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.2.1...v1.3.0

## v1.2.1 - 2024-03-08

### What's Changed

#### 🐛 Bug Fixes

* bug: Fix no VPC SG checks (#71) @fatbasstard

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.2.0...v1.2.1

## v1.2.0 - 2024-03-08

### What's Changed

#### 🚀 Features

* feature: Add security group as input (#67) @fatbasstard

#### 🐛 Bug Fixes

* bug: fixes creating role when no role_arn is specified  (#69) @stefanwb
* feature: Add security group as input (#67) @fatbasstard

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.1.2...v1.2.0

## v1.1.2-hotfix-reuse-sg - 2023-12-19

This is a temporary hotfix release to enable the reuse of Security Groups. This is done to prevent hitting Hyperplane ENI limits.

See:

* https://aws.plainenglish.io/dealing-with-you-have-exceeded-the-maximum-limit-for-hyperplane-enis-for-your-account-223147e7ab64
* https://docs.aws.amazon.com/lambda/latest/dg/foundation-networking.html

Structural implementation requires refactoring, therefor a temporary hotfix release (on a hotfix branch)

## v1.1.2 - 2023-11-17

### What's Changed

#### 🐛 Bug Fixes

- fix: Allow sourcecode hash also for s3 (#66) @jverhoeks

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.1.1...v1.1.2

## v1.1.1 - 2023-10-25

### What's Changed

#### 🐛 Bug Fixes

- fix: SG already exists error when recreating with create_before_destroy by introducing a `security_group_name_prefix` variable  (#64) @stefanwb

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.1.0...v1.1.1

## v1.1.0 - 2023-10-05

### What's Changed

#### 🚀 Features

- feature: allow referencing ipv6 and other security groups in the `security_group_egress_rules` variable (#63) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v1.0.0...v1.1.0

## v1.0.0 - 2023-10-04

### What's Changed

#### 🚀 Features

- enhancement: update workflows, add example, solve findings, add option to specify code_signing_config_arn (#62) @marwinbaumannsbp
- breaking: remove explicit configuration alias (#60) @nitrocode

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v0.4.0...v1.0.0

## v0.4.0 - 2023-09-22

### What's Changed

#### 🚀 Features

- feat: Enable egress configuration (#61) @stefanwb

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-lambda/compare/v0.3.13...v0.4.0
