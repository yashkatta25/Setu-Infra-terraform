resource "aws_lb" "q2-alb" {
  name               = var.project_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.q2-alb.id]
  subnets            = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id]
 
  enable_deletion_protection = false
}
 
resource "aws_alb_target_group" "q2-lb-tg" {
  name        = var.project_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.q2-vpc.id
  target_type = "ip"
 
  health_check {
   healthy_threshold   = "3"
   interval            = "30"
   protocol            = "HTTP"
   matcher             = "200"
   timeout             = "3"
   path                = "/"
   unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.q2-alb.id
  port              = 80
  protocol          = "HTTP"
 
  default_action {
    target_group_arn = aws_alb_target_group.q2-lb-tg.id
    type             = "forward"
  }
}
