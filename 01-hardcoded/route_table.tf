resource "aws_route_table" "public" {
  vpc_id = aws_vpc.cccr2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cccr2.id
  }

  tags = {
    Name = "cccr2-rt-public"
  }
}

resource "aws_route_table" "private01" {
  vpc_id = aws_vpc.cccr2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw01.id
  }

  tags = {
    Name = "cccr2-rt-private01"
  }
}

resource "aws_route_table" "private02" {
  vpc_id = aws_vpc.cccr2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw02.id
  }

  tags = {
    Name = "cccr2-rt-private02"
  }
}