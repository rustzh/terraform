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

resource "aws_route_table_association" "public01" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public01.id
}

resource "aws_route_table_association" "public02" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public02.id
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

resource "aws_route_table_association" "private01" {
  route_table_id = aws_route_table.private01.id
  subnet_id      = aws_subnet.private01.id
}

resource "aws_route_table_association" "private02" {
  route_table_id = aws_route_table.private02.id
  subnet_id      = aws_subnet.private02.id
}