# 信頼ポリシー
data "aws_iam_policy_document" "eks_fargate_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    
    principals {
      type = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    
    principals {
      type = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

# IAMロール
resource "aws_iam_role" "eks_fargate_pod_execution_role" {
  name = "eks-fargate-pod-execution"
  assume_role_policy = data.aws_iam_policy_document.eks_fargate_assume_role.json
}
resource "aws_iam_role" "eks_role" {
  name = "eks-master"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

# IAMポリシーのアタッチ
resource "aws_iam_role_policy_attachment" "eks_fargate_pod_execution" {
  role = aws_iam_role.eks_fargate_pod_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}
resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  role = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSServicePolicy" {
  role = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}