resource "aws_autoscaling_group" "nginx_asg" {
  name                 = "Nginx-asg"
  max_size             = 3
  min_size             = 1
  desired_capacity     = 2
  force_delete         = true
  launch_configuration = aws_launch_configuration.webserver_launch_config.name
  vpc_zone_identifier  = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  tag {
    key                 = "Name"
    value               = "Nginx-web-server-asg"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "nginx_auto_attach" {
  autoscaling_group_name = aws_autoscaling_group.nginx_asg.id
  alb_target_group_arn   = aws_lb_target_group.nginx-alb-target.arn
}

resource "aws_launch_configuration" "webserver_launch_config" {
  name                 = "web_config"
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.wordpress.id
  security_groups      = [aws_security_group.nginx_sg.id]
  user_data            = data.template_file.asg_init.rendered
  lifecycle {
    create_before_destroy = true
  }
}

