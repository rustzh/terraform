resource "aws_subnet" "public01" {
  vpc_id                  = aws_vpc.cccr2.id
  availability_zone       = "ap-northeast-2a"
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "cccr2-subnet-public01"
  }
}

resource "aws_subnet" "public02" {
  vpc_id                  = aws_vpc.cccr2.id
  availability_zone       = "ap-northeast-2c"
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "cccr2-subnet-public02"
  }
}

resource "aws_subnet" "private01" {
  vpc_id            = aws_vpc.cccr2.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.0.64.0/20"

  tags = {
    Name = "cccr2-subnet-private01"
  }
}

resource "aws_subnet" "private02" {
  vpc_id            = aws_vpc.cccr2.id
  availability_zone = "ap-northeast-2c"
  cidr_block        = "10.0.80.0/20"

  tags = {
    Name = "cccr2-subnet-private02"
  }
}