resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "Udemy demo vpc"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_ips[0]
  availability_zone = var.availability_zone_1
  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_ips[1]
  availability_zone = var.availability_zone_2
  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_ips[0]
  availability_zone = var.availability_zone_1
  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_ips[1]
  availability_zone = var.availability_zone_2
  tags = {
    Name = "Private Subnet 2"
  }
}

#Create IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  
}

#Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_1.id
}

#Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Udemy public RTB"
  }
}   

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}

#Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Udemy private RTB"
  }
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
}

#Associate private route table with private subnets
resource "aws_route_table_association" "private_subnet_association_1" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

#Associate public route table with private subnets
resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}