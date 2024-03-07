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

  security_group_config = {
    name_prefix = "prefix-"
    egress_rules = [
      {
        description = "HTTPS to any"
        cidr_ipv4   = "0.0.0.0/0"
        from_port   = "443"
        to_port     = "443"
        ip_protocol = "tcp"
      },
    ]
  }
}

