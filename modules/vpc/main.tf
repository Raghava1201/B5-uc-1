resource "aws_vpc" "alb-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "alb-vpc"
  }  
}

resource "aws_subnet" "public_a" {
  vpc_id       = aws_vpc.alb-vpc.id
  cidr_block   = var.subnet_a_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id       = aws_vpc.alb-vpc.id
  cidr_block   = var.subnet_b_cidr
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id       = aws_vpc.alb-vpc.id
  cidr_block   = var.subnet_c_cidr
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-c"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id   = aws_vpc.alb-vpc.id
  tags = {
    Name = "alb-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.alb-vpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public_igw" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_rt_association_a" {
  subnet_id = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_association_b" {
  subnet_id = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_association_c" {
  subnet_id = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_rt.id
}