### What is this script about
This Terraform script is an Infrastructure as Code (IaC) configuration written to automate the creation and configuration of resources in Amazon Web Services (AWS). Let's break down.

## Purpose
The script creates a basic AWS infrastructure with networking, security, and an EC2 instance for deploying and running a Python application (using Flask). It sets up the necessary environment and deploys the application directly onto the instance.


## Explanation of Each Component

    # 1. Provider Configuration:

	provider "aws" {
  	   region = "ap-south-1"
	}

      -   Purpose: Configures Terraform to use the AWS provider and specifies the region (ap-south-1 for Mumbai).

      - This is necessary for Terraform to know which cloud provider and region to interact with.


    # 2. Variable Declaration:
 
        variable "cidr" {
          default = "10.0.0.0/16"
        }
 
      - Purpose: Defines a variable cidr with a default value of 10.0.0.0/16.

      - This is the range of IP addresses for the Virtual Private Cloud (VPC). A /16 CIDR block provides up to 65,536 IP addresses


    # 3. Key Pair Resource:

        resource "aws_key_pair" "example" {
          key_name   = "harryb"
          public_key = file("~/.ssh/id_rsa.pub")
       }

      - Purpose: Creates an SSH key pair with the name harryb and uses a public key from the specified file (~/.ssh/id_rsa.pub).

      - This key pair will be used to securely access the EC2 instance.

    # 4. VPC and Subnet:

     >  VPC (aws_vpc):
       
        resource "aws_vpc" "myvpc" {
          cidr_block = var.cidr
        }

      - Purpose: Creates a VPC with the CIDR block 10.0.0.0/16 (as defined earlier).

      - A VPC is a logically isolated network in AWS.


     > Subnet (aws_subnet):
 
       resource "aws_subnet" "sub1" {
         cidr_block              = "10.0.0.0/24"
         vpc_id                  = aws_vpc.myvpc.id
         availability_zone       = "ap-south-1"
         map_public_ip_on_launch = true
       }

     - Purpose: Creates a subnet within the VPC.

        -  Subnet CIDR block: 10.0.0.0/24 (a smaller range within the VPC).
        - map_public_ip_on_launch = true: Automatically assigns public IP addresses to instances in this subnet.
 
     - Availability Zone: Located in ap-south-1. 

# 5. Internet Gateway and Routing:

     > Internet Gateway:

        resource "aws_internet_gateway" "igw" {
         vpc_id = aws_vpc.myvpc.id
      }

    - Provides internet connectivity to resources within the VPC.

    > Route Table:
 
        resource "aws_route_table" "RT" {
          vpc_id = aws_vpc.myvpc.id

        route {
         cidr_block = "0.0.0.0/0"
         gateway_id = aws_internet_gateway.igw.id
          }
        }

    - Purpose: Defines a route table with a route to direct all traffic (0.0.0.0/0) to the Internet Gateway.

    - Ensures that resources in the VPC can communicate with the internet. 

# 6. Associate the Route Table with the Subnet 

        resource "aws_route_table_association" "rta1" {
          subnet_id      = aws_subnet.sub1.id
          route_table_id = aws_route_table.RT.id
         }

    - Purpose: Links the route table to the subnet, enabling internet access for resources in the subnet.

#7. Create a Security Group

      resource "aws_security_group" "webSg" {
       name   = "web"
       vpc_id = aws_vpc.myvpc.id

       ingress {
         description = "HTTP from VPC"
         from_port   = 80
         to_port     = 80
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
       }

      egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
      }

      tags = {
       Name = "Web-sg"
      }
     }

   - Purpose: Configures a security group (webSg) for the EC2 instance:
      - Ingress Rules:
         - Allow HTTP traffic on port 80 from any IP.
         - Allow SSH traffic on port 22 from any IP.

      - Egress Rules:
         - Allow all outbound traffic.

#8. Create an EC2 Instance

      resource "aws_instance" "server" {
         ami                    = "ami-0dee22c13ea7a9a67"  # Amazon Linux AMI
         instance_type          = "t2.micro"  # Free tier eligible instance type
         key_name               = aws_key_pair.example.key_name
         vpc_security_group_ids = [aws_security_group.webSg.id]
         subnet_id              = aws_subnet.sub1.id

         connection {
           type        = "ssh"
           user        = "ubuntu"  # Default username for Ubuntu AMIs
           private_key = file("~/.ssh/id_rsa")  # Path to your private key
           host        = self.public_ip
         }

         provisioner "file" {
           source      = "app.py"  # Local file to copy to the EC2 instance
           destination = "/home/ubuntu/app.py"  # Destination path on the EC2 instance
         }

         provisioner "remote-exec" {
           inline = [
             "echo 'Hello from the remote instance'",
             "sudo apt update -y",  # Update the system
             "sudo apt-get install -y python3-pip",  # Install pip3
             "cd /home/ubuntu",
             "sudo pip3 install flask",  # Install Flask
             "sudo python3 app.py &",  # Start the application
           ]
         }
      }

    - Purpose: Provisions an EC2 instance with the following:

       - AMI: Amazon Machine Image (Ubuntu in this case).
       - Instance Type: t2.micro (suitable for testing and free tier).
       - Key Pair: Used for secure SSH access.
       - Security Group: Restricts access to HTTP and SSH only.
       - Subnet: Places the instance in the created subnet.
       - File Provisioner: Copies a local file (app.py) to the instance.

       - Remote Exec Provisioner: Executes remote commands:
          1. Updates the system.
          2. Installs pip3 and Flask.
          3. Starts the app.py Flask application.
