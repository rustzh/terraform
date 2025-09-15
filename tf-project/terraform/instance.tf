data "aws_ssm_parameter" "amazon_linux_2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

data "aws_ssm_parameter" "ubuntu_22_04_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "pub_web01" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2023_ami.value
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.my_key_openssh.key_name
  subnet_id                   = aws_subnet.vpc01_public01a.id

  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "pub-web01"
  }
}

resource "aws_instance" "pub_web02" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2023_ami.value
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.my_key_openssh.key_name
  subnet_id                   = aws_subnet.vpc01_public02c.id

  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "pub-web02"
  }
}

resource "aws_instance" "database01" {
  ami           = data.aws_ssm_parameter.ubuntu_22_04_ami.value
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key_openssh.key_name
  subnet_id     = aws_subnet.vpc01_private01a.id

  vpc_security_group_ids = [aws_security_group.db.id]

  tags = {
    Name = "database01"
  }
}