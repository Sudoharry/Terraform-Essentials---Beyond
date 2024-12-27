# Provider configuration for AWS
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "ap-south-1"
}

# Resource block to create an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-053b12d3152c0cc71"
  instance_type = "t2.micro"
  tags = {
    Name = "AWS-IAM-Instance"
  }
}

# Resource block to create a secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "example" {
  name = "my-new-secret-api-key"
}

# Store the secret value (API key) in AWS Secrets Manager
resource "aws_secretsmanager_secret_version" "example_version" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = jsonencode({
    api_key = "your-api-key"
  })
}

# Data block to reference the secret from Secrets Manager
data "aws_secretsmanager_secret" "example" {
  name = aws_secretsmanager_secret.example.name
}

# Data block to retrieve the secret version
data "aws_secretsmanager_secret_version" "example_version" {
  secret_id = data.aws_secretsmanager_secret.example.id
}

# Corrected: Use the secret (api_key) stored in Secrets Manager and store it in an S3 bucket object
resource "aws_s3_object" "example" {
  bucket = "aws-harry-8849964295"
  key    = "api-key.txt"
  content = jsondecode(data.aws_secretsmanager_secret_version.example_version.secret_string)["api_key"]
  acl    = "private"  # Ensure the proper access control is set
}
