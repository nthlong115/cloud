template = {
  image_id      = "ami-069aabeee6f53e7bf"
  instance_type = "t2.micro"
  name_prefix   = "my-teamplate"
}

asg = {
  capacity_rebalance        = true
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  max_size                  = 4
  min_size                  = 1
  on_demand_base_capacity   = 1
  on_demand_percentage_above_base_capacity = 25
  spot_allocation_strategy                 = "capacity-optimized"
}