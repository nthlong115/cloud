resource "aws_eks_cluster" "cluster" {
  name     = var.me_name
  role_arn = aws_iam_role.policy.arn
  version  = var.me_version
  enabled_cluster_log_types = [ "api","audit","authenticator","controllerManager","scheduler" ]

  vpc_config {
    subnet_ids = var.sub_eks
  }

  depends_on = [
    aws_iam_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_policy_attachment.AmazonEKSVPCResourceController
  ]
  tags = {
    Name = "${var.me_name}"
  }
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
  tags = {
    Name = "Eks-Policy"
  }
}

resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles = [aws_iam_role.policy.name]
  name = "at1"
}

resource "aws_iam_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  roles = [aws_iam_role.policy.name]
  name = "at2"
}