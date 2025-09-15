# 등록된 도메인 불러오기
data "aws_route53_zone" "primary" {
  name         = "div4u.com"
  private_zone = false # public으로 사용
}

resource "aws_route53_record" "bastion" {
  zone_id = data.aws_route53_zone.primary.zone_id # 그냥 id가 아닌 zone_id
  name    = "bastion.div4u.com"                   # 레코드 이름만 작성하는 게 아닌 도메인 포함 풀네임 작성
  type    = "A"
  ttl     = 300
  records = [
    aws_instance.cccr2_bastion.public_ip
  ]
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "www.div4u.com"
  type    = "A"

  alias {
    name                   = aws_lb.cccr2_elb.dns_name # 로드 밸런서의 DNS 이름을 설정
    zone_id                = aws_lb.cccr2_elb.zone_id
    evaluate_target_health = true
  }
}