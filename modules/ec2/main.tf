resource "aws_instance" "instance_A" {
  ami    = var.ami_id
  instance_type = var.instance_type
  subnet_id  = var.subnet_ids["a"]
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.Instance-sg.id]
  user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install nginx -y
        echo "<h1>Welcome to Homapage - Instance A</h1>" | sudo tee /var/www/html/index.html
        sudo systemctl start nginx
        EOF
  tags = {
    Name = "instance_A"
  }
}

resource "aws_instance" "instance_B" {
  ami    = var.ami_id
  instance_type = var.instance_type
  subnet_id  = var.subnet_ids["b"]
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.Instance-sg.id]
  user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install nginx -y
        sudo rm -rf /var/www/html/index.nginx-debian.html
        sudo mkdir /var/www/html/images
        echo "<h1>Images Page - Instance B</h1>" | sudo tee /var/www/html/images/index.html
        sudo systemctl restart nginx
        EOF
  tags = {
    Name = "instance_B"
  }
}

resource "aws_instance" "instance_C" {
  ami    = var.ami_id
  instance_type = var.instance_type
  subnet_id  = var.subnet_ids["c"]
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.Instance-sg.id]
  user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install nginx -y
        sudo rm -rf /var/www/html/index.nginx-debian.html
        sudo mkdir /var/www/html/register
        echo "<h1>Register Page - Instance C</h1>" | sudo tee /var/www/html/register/index.html
        sudo systemctl restart nginx
        EOF
  tags = {
    Name = "instance_C"
  }
}

resource "aws_security_group" "Instance-sg" {
  name_prefix = "instance-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group_attachment" "A" {
  target_group_arn = var.target_group_a_arn
  target_id        = aws_instance.instance_A.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "B" {
  target_group_arn = var.target_group_b_arn
  target_id        = aws_instance.instance_B.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "C" {
  target_group_arn = var.target_group_c_arn
  target_id        = aws_instance.instance_C.id
  port             = 80
}