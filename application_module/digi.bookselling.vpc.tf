#VPC with public network
#private network
#internet gw
#nat gw
#route table

resource "aws_vpc" "digi-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "base-network-vpc"
  }
}

resource "aws_subnet" "digi-pri-subnet1" {
  vpc_id            = aws_vpc.digi-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "base-network-pri-subnet1"
  }
}

resource "aws_subnet" "digi-pri-subnet2" {
  vpc_id            = aws_vpc.digi-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "base-network-pri-subnet2"
  }
}

resource "aws_subnet" "digi-pub-subnet1" {
  vpc_id                  = aws_vpc.digi-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "base-network-pub-subnet1"
  }
}

resource "aws_subnet" "digi-pub-subnet2" {
  vpc_id                  = aws_vpc.digi-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-ease-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "base-netowrk-pub-subnet2"
  }
}

resource "aws_internet_gateway" "digi-igw" {
  vpc_id = aws_vpc.digi-vpc.id
  tags = {
    Name = "base-network-igw"
  }
}

resource "aws_route_table" "digi-pub-rt" {
  vpc_id = aws_vpc.digi-vpc.id
}

resource "aws_route_table_association" "digi-rt-acc" {
  route_table_id = aws_route_table.digi-pub-rt.id
  subnet_id      = aws_subnet.digi-pub-subnet1.id
}

resource "aws_route_table_association" "digi-rt-acc2" {
  route_table_id = aws_route_table.digi-pub-rt.id
  subnet_id      = aws_subnet.digi-pub-subnet2.id
}

resource "aws_route" "digi-pub-route" {
  route_table_id         = aws_route_table.digi-pub-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.digi-igw.id
}

resource "aws_eip" "digi-pub-eip" {
  vpc = true
}

resource "aws_nat_gateway" "digi-pub-nat" {
  allocation_id = aws_eip.digi-pub-eip.id
  subnet_id     = aws_subnet.digi-pub-subnet1.id
}

resource "aws_route_table" "digi-pri-rt" {
  vpc_id = aws_vpc.digi-vpc.id
}

resource "aws_route_table_association" "digi-pri-rt-acc1" {
  route_table_id = aws_route_table.digi-pri-rt.id
  subnet_id      = aws_subnet.digi-pri-subnet1.id
}

resource "aws_route_table_association" "digi-pri-rt-acc2" {
  route_table_id = aws_route_table.digi-pri-rt.id
  subnet_id      = aws_subnet.digi-pri-subnet2.id
}

resource "aws_route" "digi-pri-route" {
  route_table_id         = aws_route_table.digi-pri-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.digi-pub-nat.id
}
