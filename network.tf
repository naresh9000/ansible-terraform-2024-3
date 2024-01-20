resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }

}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }

}

resource "aws_subnet" "subnet1-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "ap-south-2a"

  tags = {
    Name = "${var.vpc_name}-public-subnet-1"
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "ap-south-2b"

  tags = {
    Name = "${var.vpc_name}-public-subnet-2"
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = "ap-south-2c"

  tags = {
    Name = "${var.vpc_name}-public-subnet-3"
  }
}

