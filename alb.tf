resource "aws_lb" "nginx-alb" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  enable_deletion_protection = false

  tags = {
    Name = "Nginx-alb"
  }
}

resource "aws_lb_target_group" "nginx-alb-target" {
  name     = "nginx-alb-target"
  port     = 80
  protocol = "HTTP"
  stickiness {
    type = "lb_cookie"
  }
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "nginx-alb-listener" {
  load_balancer_arn = aws_lb.nginx-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-alb-target.arn
  }
}