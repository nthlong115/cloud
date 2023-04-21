variable "my_eks" {
  type = object({
    name     = string
    role_arn = string
    version  = string
  })
}

variable "sub_eks" {
  type = string
}