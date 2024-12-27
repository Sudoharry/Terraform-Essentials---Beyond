provider "aws" {
  region = "ap-south-1"
}

# Security Group Creation
resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow inbound SSH traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Data Source to reference an existing security group
data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["my-security-group"]
  }
}

# EC2 Instance Creation (depends on the Security Group implicitly)
resource "aws_instance" "example" {
  ami = "ami-053b12d3152c0cc71"
  instance_type = "t2.micro"

  security_groups = [data.aws_security_group.existing_sg.name]

  tags = {
    Name = "AWS-IAM-Instance"
  }

} 

# Output the Security Group ID
output "sg_id" {
  value = aws_security_group.my_sg.id
}



