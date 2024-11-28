provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  address = "http://<ec2_instance_id>" #Add your instance ID
  skip_child_token = true  #Recommend by HashiCorp Doc */

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id = "<Add your role id>"  
      secret_id = "<Add your secret id>" 

    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"   
  name  = "test-secret"  
}

resource "aws_instance" "my_instance" {
  ami = "ami-0dee22c13ea7a9a67" #Add ami from your machine from console
  instance_type = "t2.micro"  #mentione which instance type you want to use

  tags = {
    Name: "test"
    Secret= data.vault_kv_secret_v2.example.data["username"]   # Data source which is 'key'coming from the secret engine
  }
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "<Add uniqiue bucket name>"  # Use a globally unique name for the S3 bucket
  tags = {
    Name   = "my-bucket"
    Secret = data.vault_kv_secret_v2.example.data["username"]  # Fetch username from the Vault secret
  }
}
