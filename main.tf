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
	tags = {
		Name = "terraform.example"
	}
}