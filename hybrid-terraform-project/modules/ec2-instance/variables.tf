variable "aws_ami" {
  description = "AWS AMI ID for the EC2 instance"
}

variable "aws_instance_type" {
  description = "AWS EC2 instance type"
  default     = "t2.micro"
}

variable "aws_instance_name" {
  description = "Name tag for the AWS EC2 instance"
  default = "terraform-ec2-instance"
}
