resource "aws_vpc" "cccr2" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "cccr2-vpc"
  }
}