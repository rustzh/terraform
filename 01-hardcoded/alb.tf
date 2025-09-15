resource "aws_lb_target_group" "cccr2-tg" {
  name     = "cccr2-tg"
  protocol = "HTTP"
  port     = 3000
  vpc_id   = aws_vpc.cccr2.id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "cccr2-tg"
  }
}

resource "aws_lb_target_group_attachment" "web01" {
  target_group_arn = aws_lb_target_group.cccr2-tg.arn
  target_id        = aws_instance.web01.id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "web02" {
  target_group_arn = aws_lb_target_group.cccr2-tg.arn
  target_id        = aws_instance.web02.id
  port             = 3000
}

resource "aws_lb" "cccr2_elb" {
  load_balancer_type = "application"
  name               = "cccr2-elb"
  internal           = false

  subnets = [
    aws_subnet.public01.id,
    aws_subnet.public02.id
  ]

  security_groups = [aws_security_group.elb.id]

  tags = {
    Name = "cccr2-elb"
  }
}

resource "aws_lb_listener" "cccr2_listener" {
  load_balancer_arn = aws_lb.cccr2_elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cccr2-tg.arn
  }
}