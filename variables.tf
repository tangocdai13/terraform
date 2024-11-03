variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "amis" {
  type = map(any)
  default = {
    "us-east-1" : "ami-06b21ccaeff8cd686"
    "ap-northeast-1" : "ami-03f584e50b2d32776"
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
}

variable "cidr_block" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.micro"  
}

variable "public_subnet_ips" {
  type = list(string)
  nullable = false
}

variable "private_subnet_ips" {
  type = list(string)
  nullable = false
}

variable "availability_zone_1" {
  type = string
}

variable "availability_zone_2" {
  type = string
}