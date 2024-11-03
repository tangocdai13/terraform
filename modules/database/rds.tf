resource "aws_db_instance" "my_db" {
  identifier           = "my-db"
  allocated_storage    = 20
  auto_minor_version_upgrade  = false
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.5"
  backup_retention_period = 7
  instance_class       = "db.t3.micro"
  db_name              = "wordpress"
  username             = "wordpress"
  password             = "wordpress"
  parameter_group_name = "default.mariadb10.5"
  skip_final_snapshot  = true

  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name = var.db_subnet_group_name[0]
}
