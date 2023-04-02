resource "aws_db_instance" "wordpress_rds_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = "wordpress_db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = var.db_name
  username               = var.db_user
  password               = jsondecode(data.aws_secretsmanager_secret_version.wp_secret.secret_string)["password"]
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  availability_zone      = "us-east-1a"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "wordpress_subnet_group"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]

  tags = {
    Name = "Wordpress RDS DB subnet group"
  }
}