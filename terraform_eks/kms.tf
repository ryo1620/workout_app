resource "aws_kms_key" "workout11" {
  description = "Customer Master Key for kubesec"
  enable_key_rotation = true
  is_enabled = true
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "workout11" {
  name = "alias/workout11-kubesec"
  target_key_id = aws_kms_key.workout11.key_id
}