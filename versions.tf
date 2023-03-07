terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.lambda]
      version               = "> 4.8.0"
    }
  }
}
