# Changelog

All notable changes to this project will automatically be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
