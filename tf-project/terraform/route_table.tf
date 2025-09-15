resource "aws_route_table" "public" {
  vpc_id = aws_vpc.cloud_vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc01_igw.id
  }

  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table_association" "public01a" {
  subnet_id      = aws_subnet.vpc01_public01a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public02c" {
  subnet_id      = aws_subnet.vpc01_public02c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private01a" {
  vpc_id = aws_vpc.cloud_vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpc01_natgw01a.id
  }

  tags = {
    Name = "rt-private-sn01a"
  }
}

resource "aws_route_table_association" "private01a" {
  subnet_id      = aws_subnet.vpc01_private01a.id
  route_table_id = aws_route_table.private01a.id
}

resource "aws_route_table" "private02c" {
  vpc_id = aws_vpc.cloud_vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpc01_natgw02c.id
  }

  tags = {
    Name = "rt-private-sn02c"
  }
}

resource "aws_route_table_association" "private02c" {
  subnet_id      = aws_subnet.vpc01_private02c.id
  route_table_id = aws_route_table.private02c.id
}