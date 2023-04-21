variable "template" {
  type = object({
    name_prefix   = string
    image_id      = string
    instance_type = string
  })
}

variable "asg" {
  type = object({
    capacity_rebalance        = bool
    desired_capacity          = number
    max_size                  = number
    min_size                  = number
    health_check_grace_period = number
    health_check_type         = string
    on_demand_base_capacity                  = number
    on_demand_percentage_above_base_capacity = number
    spot_allocation_strategy                 = string
  })
}

variable "asg_vpc_zone" {
  type = string
}

variable "target_group_arn" {
  type = string
}