
#creating vpc  enable dns
resource "aws_vpc" "X_VPC"{
  
  cidr_block  = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {

    Name = "Insta_VPC"
  }

}

#Creating 2 public 
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.X_VPC.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]


  tags = {
    Name = var.public_subnet_names[count.index]
  }
}

#Creating 2 private subnets
resource "aws_subnet" "private_subnets" {

  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.X_VPC.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = var.private_subnet_names[count.index]
  }

}

#Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.X_VPC.id

  tags = {
    Name = "Insta_VPC_IGW"
  }

}

#Create public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.X_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "Insta_VPC_publi_rt"
  }

  depends_on = [aws_internet_gateway.gw]
}

#create eip
resource "aws_eip" "nat_ip" {

  domain   = "vpc"
}

#create nategateway
resource "aws_nat_gateway" "nat_gateway" {

  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnets[1].id
  #var.public_subnets_cidr[count.index].id

  tags = {
    Name = "NatGateway-X"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]

}



#Create private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.X_VPC.id

  route {
    cidr_block = aws_vpc.X_VPC.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }


  tags = {
    Name = "Insta_VPC_private_rt"
  }
}

#public route table association
resource "aws_route_table_association" "public-rt-association" {

  count = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
  depends_on = [aws_subnet.public_subnets,aws_route_table.public_rt]

}

#private route table association
resource "aws_route_table_association" "private-rt-association" {

  count = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
  depends_on = [aws_subnet.private_subnets,aws_route_table.private_rt]
  
}


