variable "alb_group" {
  type = object({
    target_type         = string
    name                = string  
    protocol            = string
    port                = number
    path                = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
  })
}

variable "lb_vpc_id" {
  type = string
}

variable "alb" {
  type = object({
  name               = string
  internal           = bool
  load_balancer_type = string
  })
}

variable "lb_sg" {
  type = string
}

variable "lb_subnet" {
  type = string
}

variable "lb_listener" {
  type = object({
    protocol          = string
    port              = number
    type              = string
  })
}

variable "public_ec2_id" {
  type = string
}

variable "private_ec2_id" {
  type = string
}