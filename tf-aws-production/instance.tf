data "cloudinit_config" "bastion_web" {
  gzip          = false # 압축 파일이 아님을 명시
  base64_encode = false # base62 인코딩이 되어 있지 않음을 명시

  part {
    filename     = "httpd.sh"
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/user_data.tpl", { web_package = "httpd" })
  }
}

resource "aws_instance" "cccr2_bastion" {
  ami = "ami-05377cf8cfef186c2"
  #instance_type               = "t2.micro"
  instance_type               = var.instance_type[var.aws_region]
  key_name                    = aws_key_pair.cccr2.key_name
  subnet_id                   = aws_subnet.public01.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.bastion.id,
    data.aws_security_group.default.id
  ]

  user_data = data.cloudinit_config.bastion_web.rendered

  tags = {
    Name = "cccr2-ec2-bastion"
  }
}

locals {
  web_servers = {
    web01 = aws_subnet.private01.id,
    web02 = aws_subnet.private02.id
  }
}

resource "aws_instance" "cccr2_web" {
  for_each = local.web_servers
  ami           = "ami-05377cf8cfef186c2"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.cccr2.key_name
  subnet_id     = each.value
  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.web.id,
    data.aws_security_group.default.id
  ]

  iam_instance_profile = aws_iam_instance_profile.cccr2_instance_profile_web.name

  user_data = <<-EOF
    #!bin/bash
    sudo dnf update
    sudo dnf -y install httpd
    curl http://127.0.0.1/var/www/html/index.html
  EOF

  tags = {
    Name = "cccr2-ec2-${each.key}"
  }
}

# locals {
#   subnet_ids = [
#     aws_subnet.private01.id,
#     aws_subnet.private02.id
#   ]
# }

# resource "aws_instance" "cccr2_web" {
#   count = 2
#   ami           = "ami-05377cf8cfef186c2"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.cccr2.key_name
#   subnet_id     = local.subnet_ids[count.index]
#   associate_public_ip_address = false

#   vpc_security_group_ids = [
#     aws_security_group.web.id,
#     data.aws_security_group.default.id
#   ]

#   iam_instance_profile = aws_iam_instance_profile.cccr2_instance_profile_web.name

#   user_data = <<-EOF
#     #!bin/bash
#     sudo dnf update
#     sudo dnf -y install httpd
#     curl http://127.0.0.1/var/www/html/index.html
#   EOF

#   tags = {
#     Name = "cccr2-ec2-web${count.index}"
#   }
# }

# resource "aws_instance" "cccr2_web01" {
#   ami           = "ami-05377cf8cfef186c2"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.cccr2.key_name
#   subnet_id     = module.cccr2_vpc.private_subnet_id

#   vpc_security_group_ids = [
#     aws_security_group.web.id,
#     data.aws_security_group.default.id
#   ]

#   iam_instance_profile = aws_iam_instance_profile.cccr2_instance_profile_web.name

#   user_data = <<-EOF
#     #!bin/bash
#     sudo dnf update
#     sudo dnf -y install httpd
#     curl http://127.0.0.1/var/www/html/index.html
#   EOF

#   tags = local.bastion_tags
# }

# resource "aws_instance" "cccr2_web02" {
#   ami           = "ami-05377cf8cfef186c2"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.cccr2.key_name
#   subnet_id     = aws_subnet.private02.id

#   vpc_security_group_ids = [
#     aws_security_group.web.id,
#     data.aws_security_group.default.id
#   ]

#   iam_instance_profile = aws_iam_instance_profile.cccr2_instance_profile_web.name

#   user_data = templatefile("${path.module}/install_mariadb.sh", { db_package = "mariadb" })

#   tags = {
#     Name = "cccr2-ec2-web02"
#   }
# }