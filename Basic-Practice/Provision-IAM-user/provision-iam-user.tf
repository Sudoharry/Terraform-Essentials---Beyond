provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "example" {
  name = "terraform-user"
}

resource "aws_iam_user_policy" "example" {
  name = "terraform-policy"
  user = aws_iam_user.example.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:ListBucket"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "*"
      }
    ]
  })
}
