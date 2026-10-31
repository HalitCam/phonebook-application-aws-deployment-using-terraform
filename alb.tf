resource "aws_alb" "my_alb" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_alb_sg.id]
  subnets            = aws_subnet.my_subnet_public[*].id

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_alb_listener" "my_alb_listener" {
  load_balancer_arn = aws_alb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_alb_target_group.arn
  }
}
