resource "aws_lb_target_group" "my_alb_target_group" {
  name        = "phonebook-tgt-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "instance"
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
  tags = {
    Name = "phonebook-web-tg"
  }
}



