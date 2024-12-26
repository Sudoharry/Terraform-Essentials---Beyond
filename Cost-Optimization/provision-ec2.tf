provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami = "ami-053b12d3152c0cc71"
  instance_type = "t2.micro"
  tags = {
    Name = "AWS-IAM-Instance"
  }
} 
resource "aws_s3_bucket" "example" {
  bucket = "terraform-example-1234567890"
} 



