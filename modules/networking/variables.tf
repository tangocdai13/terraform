variable "cidr_block" {
  type = string
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