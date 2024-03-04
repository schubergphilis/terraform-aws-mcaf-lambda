provider "aws" {
  region = "eu-west-1"
}

module "lambda" {
  source = "../.."

  name = "example"

  subnet_ids = [
    "subnet-00000000000000000",
    "subnet-00000000000000000"
  ]
}
