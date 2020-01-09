# Repository
resource "aws_ecr_repository" "workout11" {
  name = "${var.app_name}-repo"
}
resource "aws_ecr_repository" "awscli_kubectl" {
  name = "awscli-kubectl"
}

# Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "workout11" {
  repository = aws_ecr_repository.workout11.name
  
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Keep only three images, expire all others",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 3
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
resource "aws_ecr_lifecycle_policy" "awscli_kubectl" {
  repository = aws_ecr_repository.awscli_kubectl.name
  
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Keep only one image, expire all others",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}