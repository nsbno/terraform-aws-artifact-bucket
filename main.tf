provider "random" {
  version = "2.1.2"
}

resource "random_string" "random_str" {
  length  = 12
  special = false
  upper   = false
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${var.name_prefix}-${random_string.random_str.result}"
  tags   = var.tags
  acl    = "private"
  policy = data.aws_iam_policy_document.artifact_bucket_policy.json
}

data "aws_iam_policy_document" "artifact_bucket_policy" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = formatlist("arn:aws:iam::%s:root", var.trusted_accounts)
    }

    actions = [
      "s3:GetObject",
    ]

    resources = ["arn:aws:s3:::${var.name_prefix}-${random_string.random_str.result}/*"]
  }
}

