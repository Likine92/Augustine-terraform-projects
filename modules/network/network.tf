resource "aws_vpc" "augustine-vpc" {
  cidr_block           = var.vpc-cidr #"10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.name}"
  }
}


resource "aws_subnet" "augustine-subnet" {
  vpc_id                  = aws_vpc.augustine-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.avZone #us-east-1a
  map_public_ip_on_launch = true

  tags = {
    Name = "augustine-sbn"
  }
}

resource "aws_internet_gateway" "augustine-igw" {
  vpc_id = aws_vpc.augustine-vpc.id

  tags = {
    Name = "terraform-igw"
  }
}


resource "aws_route_table" "augustine-igw" {
  vpc_id = aws_vpc.augustine-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.augustine-igw.id
  }


  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.augustine-subnet.id
  route_table_id = aws_route_table.augustine-igw.id
}
