terraform {
  backend "s3" {
    bucket         = "harendra-s3-demo-aws" # change this
    key            = "harryb/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
