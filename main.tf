terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_iam_role" "prod-ci-role" {
  name = "prod-ci-role"
  managed_policy_arns = [aws_iam_policy.ci-prod-policy-1.arn]

  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Deny",
      "Principal": {
        Service = "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
)

  tags = {
    tag-key = "tag-value"
  }
}


resource "aws_iam_policy" "ci-prod-policy-1" {
  name = "ci-prod-policy-1"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group" "prod-ci-group" {
  name = "group1"
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.prod-ci-group.name
  policy_arn = aws_iam_policy.ci-prod-policy-1.arn
}


resource "aws_iam_user" "prod-ci-jnguyen" {
  name = "jnguyen"
}

resource "aws_iam_user_group_membership" "prod-ci-membership1" {
  user = aws_iam_user.prod-ci-jnguyen.name

  groups = [
    aws_iam_group.prod-ci-group.name
  ]
}
