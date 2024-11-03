resource "aws_security_group" "udemy_demo_public_sg" {
  name = "udemy_demo_public_sg"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "udemy_demo_public_sg"
  }
}

resource "aws_security_group" "udemy_demo_private_sg" {
  name = "udemy_demo_private_sg"
  vpc_id = var.vpc_id

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    security_groups = [aws_security_group.udemy_demo_public_sg.id]
  }
  ingress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    security_groups = [aws_security_group.udemy_demo_public_sg.id]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "udemy_demo_private_sg"
  }
}