resource "aws_iam_instance_profile" "wordpress" {
  name = "wordpress-instance-profile"
  role = aws_iam_role.wordpress_ec2_role.name
}

resource "aws_iam_role" "wordpress_ec2_role" {
  name = "wordpress-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "efs_policy" {
  name   = "efs-policy"
  policy = data.aws_iam_policy_document.efs_policy.json
}

data "aws_iam_policy_document" "efs_policy" {
  statement {
    effect  = "Allow"
    actions = ["elasticfilesystem:*"]
    resources = ["${aws_efs_file_system.wordpress_efs.arn}",
    "${aws_db_instance.wordpress_rds_instance.arn}/*"]
  }
}

resource "aws_iam_role_policy_attachment" "efs_attachment" {
  policy_arn = aws_iam_policy.efs_policy.arn
  role       = aws_iam_role.wordpress_ec2_role.name
}

resource "aws_iam_policy" "rds_policy" {
  name   = "rds-policy"
  policy = data.aws_iam_policy_document.rds_policy.json
}

data "aws_iam_policy_document" "rds_policy" {
  statement {
    effect = "Allow"
    actions = [
      "rds:CreateDBSnapshot",
      "rds:DeleteDBSnapshot",
      "rds:DescribeDBSnapshots",
      "rds:RestoreDBInstanceFromDBSnapshot"
    ]
    resources = [
      "${aws_db_instance.wordpress_rds_instance.arn}",
      "${aws_db_instance.wordpress_rds_instance.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "rds_attachment" {
  policy_arn = aws_iam_policy.rds_policy.arn
  role       = aws_iam_role.wordpress_ec2_role.name
}