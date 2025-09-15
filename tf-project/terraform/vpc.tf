resource "aws_vpc" "cloud_vpc01" {
  cidr_block = "172.20.0.0/16"

  tags = {
    Name = "cloud-vpc01"
  }
}