resource "aws_lb" "application" {
  name               = "application-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = values(var.subnet_ids)
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application.arn
  port              = "80"
  protocol            = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.a.arn
  }
}

resource "aws_lb_target_group" "a" {
  name     = "tg-a"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = 80
    protocol = "HTTP"
    matcher = "200"
  }
}

resource "aws_lb_target_group" "b" {
  name     = "tg-b"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/images"
    port = 80
    protocol = "HTTP"
    matcher = "200"
  }
}

resource "aws_lb_target_group" "c" {
  name     = "tg-c"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/register"
    port = 80
    protocol = "HTTP"
    matcher = "200"
  }
}

resource "aws_lb_listener_rule" "register" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.c.arn
  }

  condition {
    path_pattern {
      values = ["/register*"]
    }
  }
}

resource "aws_lb_listener_rule" "images" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.b.arn
  }

  condition {
    path_pattern {
      values = ["/images*"]
    }
  }
}

resource "aws_security_group" "alb" {
  name_prefix = "alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}