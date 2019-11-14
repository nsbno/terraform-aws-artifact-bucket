data "aws_caller_identity" "current" {}
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.name_prefix}-artifacts"
  tags   = var.tags
  acl    = "private"
  policy = data.aws_iam_policy_document.artifact_bucket_policy.json
}

data "aws_iam_policy_document" "artifact_bucket_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.trusted_accounts)
    }
    actions = [
      "s3:GetObject",
    ]
    resources = ["arn:aws:s3:::${data.aws_caller_identity.current.account_id}-${var.name_prefix}-artifacts/*"]
  }
}

