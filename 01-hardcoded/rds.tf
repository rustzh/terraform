resource "aws_db_parameter_group" "cccr2_db_pg" {
  name        = "cccr2-db-pg"
  description = "cccr2 parameter group"
  family      = "mysql8.0"

  tags = {
    Name = "cccr2-db-pg"
  }
}

resource "aws_db_option_group" "cccr2_db_og" {
  name                     = "cccr2-db-og"
  option_group_description = "cccr2 option group"
  engine_name              = "mysql"
  major_engine_version     = "8.0"

  tags = {
    Name = "cccr2-db-og"
  }
}

resource "aws_db_subnet_group" "cccr2_db_subnet" {
  name        = "cccr2-db-subnet"
  description = "cccr2 subnet group"
  subnet_ids = [
    aws_subnet.private01.id,
    aws_subnet.private02.id
  ]

  tags = {
    Name = "cccr2-db-subnet"
  }
}

resource "aws_db_instance" "cccr2_db" {
  engine            = "mysql"
  engine_version    = "8.0"
  identifier        = "cccr2-db"
  username          = "admin"
  password          = "admin123"
  instance_class    = "db.t3.medium"
  allocated_storage = "20"

  db_subnet_group_name   = aws_db_subnet_group.cccr2_db_subnet.name
  vpc_security_group_ids = [aws_security_group.db.id]
  parameter_group_name   = aws_db_parameter_group.cccr2_db_pg.name
  option_group_name      = aws_db_option_group.cccr2_db_og.name
  skip_final_snapshot    = true
  deletion_protection    = false
  apply_immediately      = true
  publicly_accessible    = false
}