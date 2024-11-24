provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "harry" {
  instance_type = "t2.micro"
  ami = "" # change this
  subnet_id = "" # change this
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "harendra-s3-demo-aws" # change this
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
