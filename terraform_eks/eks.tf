# CloudWatch
resource "aws_cloudwatch_log_group" "workout11" {
  name              = "/aws/eks/${var.app_name}-eks/cluster"
  retention_in_days = 180
}

# EKS Cluster
resource "aws_eks_cluster" "workout11" {
  name     = "${var.app_name}-eks"
  version  = "1.14"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    security_group_ids = [module.eks_sg.security_group_id]
    subnet_ids         = [aws_subnet.private_0.id, aws_subnet.private_1.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.workout11
  ]

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}

# EKS security group
module "eks_sg" {
  source      = "./security_group"
  name        = "eks-sg"
  tag_name    = "eks-sg"
  vpc_id      = aws_vpc.workout11.id
  port        = 80
  cidr_blocks = [aws_vpc.workout11.cidr_block]
}

# EKS Fargate
resource "aws_eks_fargate_profile" "workout11" {
  cluster_name           = aws_eks_cluster.workout11.name
  fargate_profile_name   = "${var.app_name}-eks-fargate"
  pod_execution_role_arn = aws_iam_role.eks_fargate_pod_execution_role.arn
  subnet_ids             = [aws_subnet.private_0.id, aws_subnet.private_1.id]

  selector {
    namespace = "default"
  }
}
resource "aws_eks_fargate_profile" "workout11_kube_system" {
  cluster_name           = aws_eks_cluster.workout11.name
  fargate_profile_name   = "${var.app_name}-eks-fargate-kube-system"
  pod_execution_role_arn = aws_iam_role.eks_fargate_pod_execution_role.arn
  subnet_ids             = [aws_subnet.private_0.id, aws_subnet.private_1.id]

  selector {
    namespace = "kube-system"
  }
}