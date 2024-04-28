# creating ALB
resource "aws_lb" "application-lb" {
  name               = "nit-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.lbsubnet1.id , aws_subnet.lbsubnet2.id]
  security_groups    = [aws_security_group.web-server.id]
  ip_address_type    = "ipv4"

  tags = {
    name = "nit-alb"
  }
}

# target group
resource "aws_lb_target_group" "nit-tg" {
  name        = "nit-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.lbvpc.id
}

resource "aws_lb_target_group_attachment" "ec2_attach1" {

  target_group_arn = aws_lb_target_group.nit-tg.arn
  target_id        = aws_instance.myinstload1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "ec2" {
  target_group_arn = aws_lb_target_group.nit-tg.arn
  target_id        = aws_instance.myinstload2.id
  port = 80
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nit-tg.arn
  }
}