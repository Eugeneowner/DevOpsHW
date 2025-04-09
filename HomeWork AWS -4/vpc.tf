provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "hw-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name  = "example-vpc"
    Owner = "Eugene"
  }
}

resource "aws_subnet" "hw-subnet-public" {
  vpc_id                  = aws_vpc.hw-vpc.id
  cidr_block              = "10.0.15.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name  = "example-subnet-public"
    Owner = "Eugene"
  }
}

resource "aws_subnet" "hw-subnet-private" {
  vpc_id     = aws_vpc.hw-vpc.id
  cidr_block = "10.0.25.0/24"

  tags = {
    Name  = "example-subnet-private"
    Owner = "Eugene"
  }
}

resource "aws_eip" "hw-eip" {
  domain = "vpc"

  tags = {
    Name  = "example-eip"
    Owner = "Eugene"
  }
}

resource "aws_internet_gateway" "hw-igw" {
  vpc_id = aws_vpc.hw-vpc.id

  tags = {
    Name  = "example-igw"
    Owner = "Eugene"
  }
}

resource "aws_nat_gateway" "hw-ngw" {
  allocation_id = aws_eip.hw-eip.id
  subnet_id     = aws_subnet.hw-subnet-public.id

  tags = {
    Owner = "Eugene"
  }
}

resource "aws_route_table" "hw-rt-public" {
  vpc_id = aws_vpc.hw-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hw-igw.id
  }

  tags = {
    Owner = "Eugene"
  }
}

resource "aws_route_table_association" "hw-rt-association-public" {
  subnet_id      = aws_subnet.hw-subnet-public.id
  route_table_id = aws_route_table.hw-rt-public.id
}

resource "aws_route_table" "hw-rt-private" {
  vpc_id = aws_vpc.hw-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.hw-ngw.id
  }

  tags = {
    Owner = "Eugene"
  }
}

resource "aws_route_table_association" "hw-rt-association-private" {
  subnet_id      = aws_subnet.hw-subnet-private.id
  route_table_id = aws_route_table.hw-rt-private.id
}