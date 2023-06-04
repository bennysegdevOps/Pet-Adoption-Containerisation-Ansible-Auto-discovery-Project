# VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.tag-vpc
  }
}

# Public Subnet 
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_sub1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.tag-public_subnet1
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_sub2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.tag-public_subnet2
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.priv_sub1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.tag-private_subnet1
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.priv_sub2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.tag-private_subnet2
  }
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.tag-igw
  }
}

# elastic ip
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
}

# NAT gateway
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = var.tag-natgw
  }
}

# Public Route Table
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.tag-public_RT
  }
}

# Private Route Table
resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.all_cidr
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = var.tag-private_RT
  }
}

# Public Route Table Association 
resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_subnet2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_RT.id
}

# Private Route Table Association 
resource "aws_route_table_association" "private_subnet1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_route_table_association" "private_subnet2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_key_pair" "key-pair" {
  key_name   = var.key_name
  public_key = var.public_key
}