resource "aws_vpc" "lbvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lbvpc"
  }
}

resource "aws_internet_gateway" "lbgateway" {
  vpc_id = aws_vpc.lbvpc.id
}

resource "aws_subnet" "lbsubnet1" {
  vpc_id = aws_vpc.lbvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "lbsubnet2" {
  vpc_id = aws_vpc.lbvpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
}