data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "template_file" "asg_init" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    db_name = var.db_name
    db_pass = var.db_pass
    db_user = var.db_user
    db_host = aws_db_instance.wordpress_rds_instance.address
    efs_id  = aws_efs_file_system.wordpress_efs.id
  }
}

data "aws_route53_zone" "domain" {
  name = var.domain_name
}