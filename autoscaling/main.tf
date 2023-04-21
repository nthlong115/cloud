resource "aws_launch_template" "template" {
  name_prefix   = var.template.name_prefix
  image_id      = var.template.image_id
  instance_type = var.template.instance_type
}

resource "aws_autoscaling_group" "asg" {
  capacity_rebalance        = var.asg.capacity_rebalance
  desired_capacity          = var.asg.desired_capacity
  max_size                  = var.asg.max_size
  min_size                  = var.asg.min_size
  health_check_grace_period = var.asg.health_check_grace_period
  health_check_type         = var.asg.health_check_type
  vpc_zone_identifier       = var.asg_vpc_zone

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = var.asg.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.asg.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.asg.spot_allocation_strategy
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.example.id
      }
      override {
        instance_type     = "t2.micro"
        weighted_capacity = "3"
      }
    }  
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = var.target_group_arn
}