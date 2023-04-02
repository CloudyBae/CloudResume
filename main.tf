resource "aws_vpc" "vpc" {
  cidr_block           = "10.97.224.0/20"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "CloudResume-VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "cloudresume-igw"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "cloudresume_private_rt"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "cloudresume_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_a_assoc" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b_assoc" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.97.232.0/22"
  availability_zone = "us-east-1a"

  tags = {
    Name = "cloudresume-private-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.97.236.0/22"
  availability_zone = "us-east-1b"

  tags = {
    Name = "cloudresume-private-b"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.97.224.0/22"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudresume-public-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.97.228.0/22"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudresume-public-b"
  }
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  description = "nginx security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "ALB SG connection"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "alb security group"
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