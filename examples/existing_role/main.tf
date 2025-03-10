provider "aws" {
  region = "eu-west-1"
}

module "lambda" {
  source = "../.."

  name = "example"

  execution_role_custom = {
    arn = "arn:aws:iam::111111111111:role/service-role/xxxxxxxxx-role-a5cxj2b1"
  }
}
