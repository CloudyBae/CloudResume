data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "aws_secretsmanager_secret" "wordpress_secret" {
  name = "wordpress_secret"
}

data "aws_secretsmanager_secret_version" "wp_secret" {
  secret_id = data.aws_secretsmanager_secret.wordpress_secret.id
}

data "template_file" "asg_init" {
  template = file(userdata.tpl)
  vars = {
    db_name = var.db_name
    db_pass = jsondecode(data.aws_secretsmanager_secret_version.wp_secret.secret_string)["password"]
    db_user = var.db_user
    db_host = aws_db_instance.wordpress_rds_instance.address
    efs_id  = aws_efs_file_system.wordpress_efs.id
  }
}

data "aws_iam_policy_document" "s3policy" {
  statement {
    actions = ["s3:GetObject"]

    resources = [
      aws_s3_bucket.website.arn,
      "${aws_s3_bucket.website.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}

data "aws_route53_zone" "domain" {
  name = var.domain_name
}