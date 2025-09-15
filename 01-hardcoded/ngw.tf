resource "aws_eip" "ngw01" {}

resource "aws_nat_gateway" "ngw01" {
  subnet_id     = aws_subnet.public01.id
  allocation_id = aws_eip.ngw01.id

  tags = {
    Name = "cccr2-ngw-01"
  }
}

resource "aws_eip" "ngw02" {}

resource "aws_nat_gateway" "ngw02" {
  subnet_id     = aws_subnet.public02.id
  allocation_id = aws_eip.ngw02.id

  tags = {
    Name = "cccr2-ngw-02"
  }
}