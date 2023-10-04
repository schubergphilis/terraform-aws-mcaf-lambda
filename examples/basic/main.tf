provider "aws" {
  region = "eu-west-1"
}


module "lambda" {
  source = "../.."

  name = "example"
}
