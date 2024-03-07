provider "aws" {
  region = "eu-west-1"
}

module "lambda" {
  source = "../.."

  name = "example"

  role_arn = "arn:aws:iam::111111111111:role/service-role/xxxxxxxxx-role-a5cxj2b1"

  subnet_ids = [
    "subnet-00000000000000000",
    "subnet-00000000000000000"
  ]

  security_group_config = {
    ids = [
      "sg-xxxxxxxxxxxxxxxxx"
    ]
  }
}
