variable "ami" {
  default = "ami-04581fbf744a7d11f"
}

variable "ec2_type" {
  type = string
  default = "t2.micro"
}

variable "aws_subnet_id" {
  type = string
}

variable "aws_sg_id" {
  type = string
}

variable "pub_ip" {
  type = bool
}