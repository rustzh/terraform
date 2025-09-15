data "aws_route53_zone" "primary" {
  name         = "div4u.com"
  private_zone = false
}

resource "aws_route53_record" "bastion" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "bastion.div4u.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.bastion.public_ip]
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "www.div4u.com"
  type    = "A"

  alias {
    name                   = aws_lb.cccr2_elb.dns_name
    zone_id                = aws_lb.cccr2_elb.zone_id
    evaluate_target_health = true
  }
}