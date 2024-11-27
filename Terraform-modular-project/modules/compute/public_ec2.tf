resource "aws_instance" "public-servers" {
  count                       = var.environment == "Production" ? 3 : 3
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  iam_instance_profile = var.iam_instance_profile
  subnet_id                   = element(var.public_subnets, count.index)
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-Public-Server-${count.index + 1}"
    environment = "${var.environment}"
  }
  user_data = <<-EOF
     #!/bin/bash
     sudo apt update
     sudo apt install nginx -y
     sudo apt install git -y
     sudo git clone https://github.com/RajPractiseRepo/Sidecar_Test.git
     sudo rm -rf /var/www/html/index.nginx-debian.html
     sudo cp  Sidecar_Test/index.html /var/www/html/index.html
     echo "<h1>${var.vpc_name}-public-Server-${count.index + 1}</h1>" >> /var/www/html/index.html
     sudo systemctl start nginx
     sudo systemctl enable nginx
 EOF
  depends_on = [var.elb_listener_public]
}