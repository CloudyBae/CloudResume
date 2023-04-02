resource "aws_vpc" "vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "CloudResume-VPC"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.123.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "cloudresume-private-a"
  }
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  description = "nginx security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx-web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  # user_data     = file("userdata.tpl")
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  subnet_id              = aws_subnet.private_subnet_a.id

  tags = {
    Name = "Nginx-webserver"
  }
}