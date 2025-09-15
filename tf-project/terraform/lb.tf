resource "aws_elb" "cloud_clb" {
  name = "cloud-clb"
  security_groups = [aws_security_group.web.id]
  subnets = [
    aws_subnet.vpc01_public01a.id,
    aws_subnet.vpc01_public02c.id
  ]
  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }
  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    target              = "HTTP:80/"
    interval            = 5
    timeout             = 2
  }

  tags = {
    Name = "cloud-clb"
  }
}

resource "aws_elb_attachment" "web01" {
  elb = aws_elb.cloud_clb.id
  instance = aws_instance.pub_web01.id
}

resource "aws_elb_attachment" "web02" {
  elb = aws_elb.cloud_clb.id
  instance = aws_instance.pub_web02.id
}