alb_group = {
  healthy_threshold   = 5
  interval            = 10
  name                = "whiz-tg"  
  path                = "/"
  port                = 80
  protocol            = "HTTP"
  target_type         = "instance"
  timeout             = 5
  unhealthy_threshold = 2
}

alb = {
  internal           = false
  load_balancer_type = "application"
  name               = "whiz-alb"
}

lb_listener = {
  port      = 80
  protocol  = "HTTP"
  type      = "forward"
}