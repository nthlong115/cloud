resource "aws_eks_cluster" "cluster" {
  name     = var.my_eks.name
  role_arn = var.my_eks.role_arn
  version  = var.my_eks.version
  enabled_cluster_log_types = [ "api","audit","authenticator","controllerManager","scheduler" ]

  vpc_config {
    subnet_ids = var.sub_eks
  }

  depends_on = [
    aws_iam_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_policy_attachment.AmazonEKSVPCResourceController
  ]
}

resource "aws_iam_role" "policy" {
  name        = "eks_policy"
  path        = "/"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  }
  POLICY
}

resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles = aws_iam_role.policy.name
}

resource "aws_iam_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  roles = aws_iam_role.policy.name
}