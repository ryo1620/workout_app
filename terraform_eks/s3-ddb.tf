terraform {
  backend "s3" {
    bucket = "workout11-tfstate"
    key    = "terraform_eks/terraform.tfstate"
    region = "ap-northeast-1"

    # tfstateに対してロックを取りつつ一貫性を維持しながら更新をかける
    dynamodb_table = "workout11-tfstate"
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.app_name}-tfstate"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  policy = data.aws_iam_policy_document.tfstate.json
}

data "aws_iam_policy_document" "tfstate" {
  statement {
    effect = "Allow"
    actions = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.tfstate.id}/*"]
    
    principals {
      type = "AWS"
      identifiers = ["582318560864"]
    }
  }
}

resource "aws_dynamodb_table" "tfstate" {
  name           = "${var.app_name}-tfstate"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}