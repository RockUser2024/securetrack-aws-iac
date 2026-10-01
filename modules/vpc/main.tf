resource "aws_vpc" "securetrack_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "securetrack-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.securetrack_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "securetrack-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.securetrack_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "securetrack-public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.securetrack_vpc.id
  cidr_block = var.private_subnet_1_cidr

  tags = {
    Name = "securetrack-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.securetrack_vpc.id
  cidr_block = var.private_subnet_2_cidr

  tags = {
    Name = "securetrack-private-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.securetrack_vpc.id

  tags = {
    Name = "securetrack-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.securetrack_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "securetrack-public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}


