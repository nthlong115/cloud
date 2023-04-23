/*variable "my_eks" {
  type = object({
    name     = string
    role_arn = string
    version  = string
  })
}*/
variable "me_name" {
  type = string
  default = "my-eks"
}
variable "me_version" {
  type = string
  default = "1.25"
}
variable "sub_eks" {
  type = list
}