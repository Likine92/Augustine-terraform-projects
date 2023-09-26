

resource "aws_instance" "HelloWorld" {
  ami                         = data.aws_ami.amazn-linux2.id
  instance_type               = var.instanceType #"t2.micro"
  key_name                    = aws_key_pair.test-key.key_name     #"terraform-key"
  subnet_id                   = aws_subnet.augustine-subnet.id
  vpc_security_group_ids      = [aws_security_group.augustine1-sg.id]
  user_data                   = file("shellscript.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_vpc" "augustine-vpc" {
  cidr_block           = var.vpc-cidr #"10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "augustine-vpc"
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

resource "aws_security_group" "augustine1-sg" {
  name        = "augustine1-sg"
  description = "Allow HTTPS and SSH inbound traffic"
  vpc_id      = aws_vpc.augustine-vpc.id

  ingress {
    description = "HTTPS from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }


  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "augustine1-sg"
  }
}

resource "aws_s3_bucket" "augustine-bucket" {
  bucket = "my-test-bucket-augustine"

  tags = {
    Name        = "my-test-bucket-augustine"

  }
}

resource "aws_key_pair" "test-key" {
  key_name = "test-key"
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDuWWD4Mlh68cDyok+O7mjfILzVkdRRq/E4Z8UN/udQJwtoA8jpDx4kr5N0byHDpei4Jrplwm+Eu7Uo4re4g5zf47kRWQ+zp1G5xksP9PstWpcjbQjsdY8vlFaweq5isOoZwgqGafbR7/DEuBFLvlSP4zJrrcJa2qOg0IhQGrRkRlseo0XNSeWt04UUnOWaM8t3HtbO2D2y98nFFjgy9nCleVmIRJ5TBVruzebzobGPMPF1gVXriudGkCQFEn4PM7E09MVE1WdOX2WLX3Np94bUa3g0jzIhx7CQ0C4FOLCbT2wfOXZ674qFbb5oatnRBXYWB6Y/VGCqITziG9VhY7fF"
  public_key = file(var.keyName)
}
