resource "aws_efs_mount_target" "public_a" {
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = aws_subnet.public_subnet_a.id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "public_b" {
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = aws_subnet.public_subnet_b.id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_file_system" "wordpress_efs" {
  creation_token = "wordpress-token"

  tags = {
    Name = "Wordpress EFS"
  }
}