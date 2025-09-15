terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
      }
    }
}

provider "aws" {
    profile = "default"
    region = "ap-northeast-2"  
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_instance" "instance" {
  ami = "ami-05377cf8cfef186c2"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true

  tags = {
    name = "default_instance"
  }
}