resource "aws_eip" "vpc01_natgw01a" {}

resource "aws_eip" "vpc01_natgw02c" {}

resource "aws_nat_gateway" "vpc01_natgw01a" {
  subnet_id     = aws_subnet.vpc01_public01a.id
  allocation_id = aws_eip.vpc01_natgw01a.id

  tags = {
    Name : "cloud-vpc01-natgw01a"
  }
}

resource "aws_nat_gateway" "vpc01_natgw02c" {
  subnet_id     = aws_subnet.vpc01_public02c.id
  allocation_id = aws_eip.vpc01_natgw02c.id

  tags = {
    Name : "cloud-vpc01-natgw02c"
  }
}