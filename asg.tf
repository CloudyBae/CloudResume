resource "aws_autoscaling_group" "nginx_asg" {
  name     = "Nginx-asg"
  max_size = 3
  min_size = 1
  #   health_check_grace_period = 300
  #   health_check_type         = "ELB"
  desired_capacity     = 2
  force_delete         = true
  launch_configuration = aws_launch_configuration.webserver_launch_config.name
  vpc_zone_identifier  = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]

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

resource "aws_launch_configuration" "webserver_launch_config" {
  name          = "web_config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.nginx_sg.id]
  user_data     = file("userdata.tpl")
}

