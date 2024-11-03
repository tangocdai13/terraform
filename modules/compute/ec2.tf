resource "aws_eip" "demo-eip" {
  instance = aws_instance.web.id
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {  
      Name = "Udemy demo"
  }
}