resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private01" {
  vpc_id            = aws_vpc.this.id
  availability_zone = var.az
  cidr_block        = var.subnet_cidr

  tags = {
    Name : "${var.vpc_name}-subnet-private01"
  }
}