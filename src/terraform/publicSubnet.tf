#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.Formiit-VPC.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public"
  }
}


# public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Formiit-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "public_route_table"
  }
}


# Association: Route table to public subnet
resource "aws_route_table_association" "public_subnet_assocTo_route_table" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}