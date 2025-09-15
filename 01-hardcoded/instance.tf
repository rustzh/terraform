resource "aws_instance" "bastion" {
  ami                         = "ami-05377cf8cfef186c2"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.cccr2.key_name
  subnet_id                   = aws_subnet.public01.id

  vpc_security_group_ids = [aws_security_group.bastion.id]

  tags = {
    Name = "cccr2-ec2-bastion"
  }
}

resource "aws_instance" "web01" {
  ami                         = "ami-05377cf8cfef186c2"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  key_name                    = aws_key_pair.cccr2.key_name
  subnet_id                   = aws_subnet.private01.id

  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = file("${path.module}/install_httpd.sh")

  tags = {
    Name = "cccr2-ec2-web01"
  }
}

resource "aws_instance" "web02" {
  ami                         = "ami-05377cf8cfef186c2"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  key_name                    = aws_key_pair.cccr2.key_name
  subnet_id                   = aws_subnet.private02.id

  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo dnf update
    sudo dnf -y install httpd
    sed -i 's/^Listen 80/Listen 3000/' /etc/httpd/conf/httpd.conf\
    echo "<h1>web01</h1>" > /var/www/html/index.html
    sudo systemctl enable httpd
    sudo systemctl start httpd
  EOF

  tags = {
    Name = "cccr2-ec2-web02"
  }
}