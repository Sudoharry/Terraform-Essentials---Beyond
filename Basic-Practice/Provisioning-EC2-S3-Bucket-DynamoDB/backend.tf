terraform {
  backend "s3" {
    bucket         = "aws-harryb-8499642954274" # Match the bucket created above
    key            = "harry/terraform.tfstate"
    region         = "ap-south-1" # Replace with your preferred region
    profile        = "terraform"
    dynamodb_table = "terraform-state-locks"
  }
}
