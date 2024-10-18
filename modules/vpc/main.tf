resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "subnets" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "us-east-1a"
  cidr_block =  var.subnet-cidr-block
  tags = {
    Name = "${var.prefix}-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}-route-table"
  }
}

resource "aws_route_table_association" "rtb-association" {
  subnet_id      = aws_subnet.subnets.id
  route_table_id = aws_route_table.rtb.id
}
