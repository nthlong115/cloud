my_eks = {
  name     = "my-eks"
  role_arn = aws_iam_role_policy.role_po.arn
  version  = "1.25"
}