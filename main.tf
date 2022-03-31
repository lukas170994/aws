terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider  "aws" {
	region = "eu-central-1"
} 
resource "aws_instance" "example" {
	ami = "ami-09d0c5df55961af29"
	instance_type = "t2.micro"
	vpc_security_group_ids = [aws_security_group.instance.id]

	user_data = <<-EOF
		#!bin/bash
		echo "Hello World!" > index.html
		nohup busybox httpd -f -p ${var.serverport} &
		EOF

	
	tags = {
		Name = "terraform.example"
	}
}

resource "aws_security_group" "instance" {

	name = "terraform-example-instance"

	ingress {	
		from_port = var.serverport
		to_port	  = var.serverport
		protocol  = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

variable serverport {
  type        = number
  default     = 8080
  description = "The Port the Server will use for HTTP Requests"
}
output publicip {
  value       = aws_instance.example.public_ip
  description = "the public ip adress of the webserver"
}
