output "security_group_id_public" {
  value = aws_security_group.udemy_demo_public_sg.id
}

output "security_group_id_private" {
  value = aws_security_group.udemy_demo_private_sg.id
}