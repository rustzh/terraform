resource "aws_instance" "instance" {
  ami = "ami-05377cf8cfef186c2"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true

  tags = {
    name = "default_instance"
  }
}