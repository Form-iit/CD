
#private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.Formiit-VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Private"
  }
}

# private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.Formiit-VPC.id

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_instance.nat_instance.primary_network_interface_id
  }

  tags = {
    Name = "private_route_table"
  }
}


# Association: Route table to private subnet
resource "aws_route_table_association" "private_subnet_assocTo_route_table" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


output "private_subnet_cidr_block" {
  value = aws_subnet.private_subnet.cidr_block
}