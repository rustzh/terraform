resource "tls_private_key" "cccr2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "cccr2" {
  key_name   = "cccr2-key"
  public_key = tls_private_key.cccr2.public_key_openssh
}

resource "local_file" "cccr2_pem" {
  content         = tls_private_key.cccr2.private_key_pem
  filename        = "cccr2-key.pem"
  file_permission = "0400"
}