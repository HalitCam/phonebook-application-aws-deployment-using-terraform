resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  
  route {
    cidr_block =  "10.0.10.0/24"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  route {
    cidr_block =  "10.0.11.0/24"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  route {
    cidr_block =  "10.0.12.0/24"
    gateway_id = aws_internet_gateway.my_igw.id
  }    
    route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
    
    route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
}


# ROUTE TABLE ASSOCIATIONS

resource "aws_route_table_association" "public_route_table_association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.my_subnet_public[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.my_subnet_private[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "igw_route_table_association" {
  gateway_id     = aws_internet_gateway.my_igw.id
  route_table_id = aws_route_table.public_route_table.id
}
