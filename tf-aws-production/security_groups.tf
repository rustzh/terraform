data "aws_security_group" "default" {
  name   = "default"
  vpc_id = aws_vpc.cccr2.id
}

resource "aws_security_group" "bastion" {
  name        = "cccr2-sg-bastion"
  description = "for bastion server"
  vpc_id      = aws_vpc.cccr2.id

  ingress {
    description = "SSH from anyware"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cccr2-sg-bastion"
  }
}

resource "aws_security_group" "elb" {
  name        = "cccr2-sg-elb"
  description = "for elb server"
  vpc_id      = aws_vpc.cccr2.id

  ingress {
    description = "HTTP from anyware"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anyware"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cccr2-sg-elb"
  }
}

resource "aws_security_group" "web" {
  name        = "cccr2-sg-web"
  description = "for web server"
  vpc_id      = aws_vpc.cccr2.id

  ingress {
    description = "SSH from anyware"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "web from anyware"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cccr2-sg-web"
  }
}

resource "aws_security_group" "database" {
  name        = "cccr2-sg-database"
  description = "for database server"
  vpc_id      = aws_vpc.cccr2.id

  ingress {
    description = "MySQL from anyware"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cccr2-sg-database"
  }
}