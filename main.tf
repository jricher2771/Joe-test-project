terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# The AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Joes-web-server" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"

  tags = {
    Name = "hello world web app"
    Env = "dev"
  }
}