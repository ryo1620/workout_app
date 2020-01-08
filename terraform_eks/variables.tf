# 環境変数AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEYに値をセットしておく
provider "aws" {
  version = "= 2.43.0"
  region     = "ap-northeast-1"
}

variable "app_name" {
  default = "workout11"
  type    = string
}