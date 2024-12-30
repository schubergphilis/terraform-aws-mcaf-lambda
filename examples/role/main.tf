provider "aws" {
  region = "eu-west-1"
}

data "aws_iam_policy_document" "lambda_iam_policy" {
  statement {
    sid       = "EC2DescribeRegionsAccess"
    actions   = ["ec2:DescribeRegions"]
    resources = ["*"]
  }
}

module "lambda" {
  source = "../.."

  name = "example"

  execution_role = {
    path   = "/custom/"
    policy = data.aws_iam_policy_document.lambda_iam_policy.json
  }
}
