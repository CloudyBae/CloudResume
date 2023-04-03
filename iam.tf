# resource "aws_iam_role" "wp-offload" {
#   name = "wp_offload"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_instance_profile" "wordpress" {
#   name = "wordpress"
#   role = aws_iam_role.wp-offload.name
# }


# resource "aws_iam_role_policy" "wp-offload" {
#   name = "wordpress_role_policy"
#   role = aws_iam_role.wp-offload.id

#   policy = jsonencode({
#     Version:"2012-10-17",
#     Statement: [
#       {
#         Sid:"PublicReadForGetBucketObjects",
#         Effect:"Allow",
#         Action:["s3:GetObject"],
#         Resource:["arn:aws:s3:::${var.domain_name}/*"]
#       }
#     ]
#   })
# }
