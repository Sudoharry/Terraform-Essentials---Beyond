provider "aws" {
  region  = "ap-south-1" # Replace with your preferred region
  profile = "terraform"
}

# S3 Bucket for Terraform Backend
resource "aws_s3_bucket" "terraform_state" {
  bucket = "aws-harryb-88499642954274" # Replace with a unique name

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB Table for Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Dev"
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-053b12d3152c0cc71"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform EC2 Instance"
  }
}