resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "my_key_pem" {
  filename        = "my-key.pem"
  content         = tls_private_key.my_key.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "my_key_openssh" {
  key_name   = "my-key"
  public_key = tls_private_key.my_key.public_key_openssh

  tags = {
    Name = "my-key"
  }
}