terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "udemy-keypair" {
  key_name = "udemy-keypair"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_sensitive_file" "private_key" {
  filename = "udemy-key.pem"
  content = tls_private_key.key.private_key_pem
  file_permission = "0400"
}

module "networking" {
  source = "./modules/networking"
  cidr_block = var.cidr_block
  public_subnet_ips = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

module "compute" {
  source = "./modules/compute"
  security_group_ids = [module.security.security_group_id_public]
  key_name = aws_key_pair.udemy-keypair.key_name
  ami_id = var.amis[var.region]
  instance_type = var.instance_type
  subnet_id = module.networking.public_subnet_ids[0]
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "database" {
  source = "./modules/database"
  security_group_ids = [module.security.security_group_id_private]
  db_subnet_group_name = module.networking.private_subnet_ids
} 