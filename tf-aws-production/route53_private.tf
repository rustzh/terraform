# 호스팅 영역 home 생성
resource "aws_route53_zone" "private_home" {
  name    = "home"
  comment = "Private zone for internal services"
  vpc {
    vpc_id = aws_vpc.cccr2.id
  }
  force_destroy = true # 호스팅 영역 삭제 시 레코드들도 모두 삭제
}

resource "aws_route53_record" "bastion_private" {
  zone_id = aws_route53_zone.private_home.zone_id
  name    = "bastion.home"
  type    = "A"
  ttl     = 300
  records = [
    aws_instance.cccr2_bastion.private_ip
  ]
}

resource "aws_route53_record" "web01_private" {
  zone_id = aws_route53_zone.private_home.zone_id
  name    = "web01.home"
  type    = "A"
  ttl     = 300
  records = [
    aws_instance.cccr2_web01.private_ip
  ]
}

resource "aws_route53_record" "web02_private" {
  zone_id = aws_route53_zone.private_home.zone_id
  name    = "web02.home"
  type    = "A"
  ttl     = 300
  records = [
    aws_instance.cccr2_web02.private_ip
  ]
}

resource "aws_route53_record" "rds_private" {
  zone_id = aws_route53_zone.private_home.zone_id
  name    = "db.home"
  type    = "CNAME"
  ttl     = 300
  records = [
    aws_db_instance.cccr2_db.address
  ]
}