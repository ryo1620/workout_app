# VPC
resource "aws_vpc" "workout11" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "${var.app_name}-VPC"
  }
}

# piblic subnet
resource "aws_subnet" "public_0" {
  vpc_id                  = aws_vpc.workout11.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.app_name}-public-subnet-a"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.workout11.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.app_name}-public-subnet-c"
  }
}

resource "aws_internet_gateway" "workout11" {
  vpc_id = aws_vpc.workout11.id
  
  tags = {
    Name = "${var.app_name}-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.workout11.id
  
  tags = {
    Name = "${var.app_name}-public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.workout11.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public_0" {
  subnet_id      = aws_subnet.public_0.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# private subnet
resource "aws_subnet" "private_0" {
  vpc_id                  = aws_vpc.workout11.id
  cidr_block              = "10.0.65.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  
  tags = {
    Name = "${var.app_name}-private-subnet-a"
    "kubernetes.io/cluster/workout11-eks" = "shared"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.workout11.id
  cidr_block              = "10.0.66.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
  
  tags = {
    Name = "${var.app_name}-private-subnet-c"
    "kubernetes.io/cluster/workout11-eks" = "shared"
  }
}

resource "aws_eip" "nat_gateway_0" {
  vpc = true
  depends_on = [aws_internet_gateway.workout11]
  
  tags = {
    Name = "${var.app_name}-nat-gateway-a-eip"
  }
}

resource "aws_eip" "nat_gateway_1" {
  vpc = true
  depends_on = [aws_internet_gateway.workout11]
  
  tags = {
    Name = "${var.app_name}-nat-gateway-c-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway_0" {
  allocation_id = aws_eip.nat_gateway_0.id
  subnet_id     = aws_subnet.public_0.id
  depends_on    = [aws_internet_gateway.workout11]
  
  tags = {
    Name = "${var.app_name}-nat-gateway-a"
  }
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_gateway_1.id
  subnet_id     = aws_subnet.public_1.id
  depends_on    = [aws_internet_gateway.workout11]
  
  tags = {
    Name = "${var.app_name}-nat-gateway-c"
  }
}

resource "aws_route_table" "private_0" {
  vpc_id = aws_vpc.workout11.id
  
  tags = {
    Name = "${var.app_name}-private-route-table-a"
  }
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.workout11.id
  
  tags = {
    Name = "${var.app_name}-private-route-table-c"
  }
}

resource "aws_route" "private_0" {
  route_table_id         = aws_route_table.private_0.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_0.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_1" {
  route_table_id         = aws_route_table.private_1.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_1.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_0" {
  subnet_id      = aws_subnet.private_0.id
  route_table_id = aws_route_table.private_0.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}