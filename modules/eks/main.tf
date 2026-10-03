resource "aws_iam_role" "eks_cluster_role" {
  name = "securetrack-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "securetrack_eks" {
  name     = "securetrack-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      var.public_subnet_1_id,
      var.public_subnet_2_id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}
