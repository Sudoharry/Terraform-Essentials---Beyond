module "aws_ec2" {
  source        = "./aws"
  aws_ami       = "ami-00bb6a80f01f03502" # Replace with the AMI ID for your region
  aws_instance_type = "t2.micro"
  aws_instance_name = "my-aws-ec2"
}

module "azure_storage" {
  source                  = "./azure"
  resource_group_name     = "my-resource-group"
  location                = "westindia"
  storage_account_name    = "harendrabarot427492" # Must be globally unique
  container_name          = "mycontainer"
}
