module "ec2-instance" {
  source        = "../modules/ec2-instance"
  aws_ami = var.aws_ami
  aws_instance_name = var.aws_instance_name
  aws_instance_type = var.aws_instance_type
}

