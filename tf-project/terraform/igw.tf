resource "aws_internet_gateway" "vpc01_igw" {
  vpc_id = aws_vpc.cloud_vpc01.id

  tags = {
    Name = "cloud-vpc01-igw"
  }
}