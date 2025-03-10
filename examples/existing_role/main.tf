provider "aws" {
  region = "eu-west-1"
}

module "role" {
  source  = "schubergphilis/mcaf-role/aws"
  version = "~> 0.4.0"

  name                  = "Example"
  principal_identifiers = ["edgelambda.amazonaws.com", "lambda.amazonaws.com"]
  principal_type        = "Service"

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

module "lambda" {
  source = "../.."

  name = "example"

  execution_role_custom = {
    arn = module.role.arn
  }
}
