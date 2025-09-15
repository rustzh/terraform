resource "aws_route53_zone" "home" {
  name = "home"
  vpc {
    vpc_id = aws_vpc.cccr2.id
  }
  force_destroy = true
}

resource "aws_route53_record" "bastion_private" {
  zone_id = aws_route53_zone.home.zone_id
  name    = "bastion.home"
  type    = "A"
  ttl     = 300
  records = [aws_instance.bastion.private_ip]
}

resource "aws_route53_record" "web01_private" {
  zone_id = aws_route53_zone.home.zone_id
  name    = "web01.home"
  type    = "A"
  ttl     = 300
  records = [aws_instance.web01.private_ip]
}

resource "aws_route53_record" "web02_private" {
  zone_id = aws_route53_zone.home.zone_id
  name    = "web02.home"
  type    = "A"
  ttl     = 300
  records = [aws_instance.web02.private_ip]
}

resource "aws_route53_record" "rds_private" {
  zone_id = aws_route53_zone.home.zone_id
  name    = "db.home"
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.cccr2_db.address]
}