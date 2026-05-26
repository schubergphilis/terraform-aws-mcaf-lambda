provider "aws" {
  region = "eu-west-1"
}


module "lambda" {
  source = "../.."

  name = "example"

  durable_config = {
    execution_timeout = 604800
    retention_period  = 14
  }
}
