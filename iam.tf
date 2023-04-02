resource "aws_iam_role" "wordpress" {
  name = "wp_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "wordpress" {
  name = "wordpress"
  role = aws_iam_role.wordpress.name
}


resource "aws_iam_role_policy" "wordpress_role" {
  name = "wordpress_role"
  role = aws_iam_role.wordpress.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:*"
        Effect = "Allow"
        Sid    = "Stmt1601591974377"
        Resource = [
          "arn:aws:s3:::34rt3tttt",
          "arn:aws:s3:::34rt3tttt/*"
        ]
      },
    ]
  })
}
