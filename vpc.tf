resource "aws_instance" "wordpress_server" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.TF_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_allow_http_ssh_sg.id]
  subnet_id              = aws_subnet.private_subnet_1.id
  tags = {
    Name = "Wordpress Server"
  }
}
resource "aws_vpc" "my_new_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "My new VPC"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_new_vpc.id
  cidr_block              = var.subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true # what makes the subnet public
  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_new_vpc.id
  cidr_block              = var.subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "public Subnet 2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.my_new_vpc.id
  cidr_block              = var.subnet_cidrs[2]
  availability_zone       = var.availability_zones[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 3"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.my_new_vpc.id
  cidr_block              = var.subnet_cidrs[3]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.my_new_vpc.id
  cidr_block              = var.subnet_cidrs[4]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet 2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.my_new_vpc.id
  cidr_block              = var.subnet_cidrs[5]
  availability_zone       = var.availability_zones[2]
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet 3"
  }
}