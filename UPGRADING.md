# Upgrading Notes

This document captures breaking changes.

## Upgrading to v1.0.0

### Behaviour

The need to provide a `providers = { aws.lambda = aws }` argument has been removed. When using v1.0.0 or higher the provider will simply default to aws and if a different provider is needed, one can be provisioned by passing down `providers = { aws = aws.lambda }`.

### Variables

The following variable defaults have been modified:

- `log_retention` -> default: `365` (previous: `14`). In order to comply with AWS Security Hub control CloudWatch.16.
- `runtime` -> default: `python3.10` (previous: `python3.9`)
- `tags` -> default: `{}` (previous: ``). We recommend to set tags on the specified AWS provider.
