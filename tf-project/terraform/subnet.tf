resource "aws_subnet" "vpc01_public01a" {
  vpc_id                  = aws_vpc.cloud_vpc01.id
  cidr_block              = "172.20.0.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloud-vpc01-public-sn01a"
  }
}

resource "aws_subnet" "vpc01_public02c" {
  vpc_id                  = aws_vpc.cloud_vpc01.id
  cidr_block              = "172.20.1.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloud-vpc01-public-sn02c"
  }
}

resource "aws_subnet" "vpc01_private01a" {
  vpc_id            = aws_vpc.cloud_vpc01.id
  cidr_block        = "172.20.32.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "cloud-vpc01-private-sn01a"
  }
}

resource "aws_subnet" "vpc01_private02c" {
  vpc_id            = aws_vpc.cloud_vpc01.id
  cidr_block        = "172.20.33.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "cloud-vpc01-private-sn02c"
  }
}