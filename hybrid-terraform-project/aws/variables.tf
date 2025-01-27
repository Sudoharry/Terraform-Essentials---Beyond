variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "ap-south-1"
  
}

variable "aws_ami" {
default = "ami-00bb6a80f01f03502"
}
variable "aws_instance_type" {
  default     = "t2.micro"
}
variable "aws_instance_name" {
  description = "Name tag for the AWS EC2 instance"

}