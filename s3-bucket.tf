resource "aws_iam_role" "ec2_role" {
  description = "Role for  ec2 access"
  name = "ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "ec2_s3_access_policy" {
  role   = aws_iam_role.ec2_role.id
  name = "ec2_s3_access_policy"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": ["s3:ListBucket"],
        "Resource": ["${aws_s3_bucket.ec2_acceess_bucket.arn}"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:GetObject"
        ],
        "Resource": ["${aws_s3_bucket.ec2_acceess_bucket.arn}/*"]
      }
    ]
  })
}

resource "aws_s3_bucket" "ec2_acceess_bucket" {
  bucket = "ec2-accessbucketmudith"
}

resource "aws_iam_instance_profile" "ec2_bucket_instance" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}


output "ec2_bucket_linked_role_arn" {
    value   = aws_iam_instance_profile.ec2_bucket_instance.arn
}
