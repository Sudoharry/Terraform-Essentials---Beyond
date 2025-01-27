/*
terraform {
  backend "s3" {
    bucket         = "hybrid-terraform-state"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
} */