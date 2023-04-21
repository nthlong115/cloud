resource "aws_lb_target_group" "target-group" {
  target_type   = var.alb_group.target_type
  name          = var.alb_group.name
  protocol      = var.alb_group.protocol
  port          = var.alb_group.port
  vpc_id        = var.lb_vpc_id
  health_check {
    protocol            = var.alb_group.protocol
    path                = var.alb_group.path
    healthy_threshold   = var.alb_group.healthy_threshold
    unhealthy_threshold = var.alb_group.unhealthy_threshold
    timeout             = var.alb_group.timeout
    interval            = var.alb_group.internal
  }
}

resource "aws_lb" "application-lb" {
  name               = var.alb.name
  internal           = var.alb.internal
  load_balancer_type = var.alb.load_balancer_type
  # security_groups = [aws_security_group.web-server.id]
  security_groups    = var.lb_sg
  subnets            = var.lb_subnet
  tags = {
    Name = "Whiz-alb"
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  protocol          = var.lb_listener.protocol
  port              = var.lb_listener.port
  default_action {
    type = var.lb_listener.type
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

resource "aws_alb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = var.public_ec2_id
}

resource "aws_alb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = var.private_ec2_id
}