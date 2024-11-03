variable "security_group_ids" {
  description = "List of Security Group IDs to associate with the instance"
  type        = list(string)
}

variable "key_name" {
    type = string
}

variable "ami_id" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "subnet_id" {
  type = string
}