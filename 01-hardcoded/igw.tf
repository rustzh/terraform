resource "aws_internet_gateway" "cccr2" {
  vpc_id = aws_vpc.cccr2.id

  tags = {
    Name = "cccr2-igw"
  }
}