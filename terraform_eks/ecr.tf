resource "aws_ecr_repository" "workout11" {
  name = "${var.app_name}-repo"
}

resource "aws_ecr_lifecycle_policy" "workout11" {
  repository = aws_ecr_repository.workout11.name
  
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Keep only ten untagged images, expire all others",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}