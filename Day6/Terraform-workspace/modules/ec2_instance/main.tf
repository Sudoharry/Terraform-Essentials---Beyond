provider "aws" {
    region = "ap-south-1"
}

variable "ami" {
  description = "ami-0dee22c13ea7a9a67"
}

variable "instance_type" {
  description = "value"
}

resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.instance_type
}
