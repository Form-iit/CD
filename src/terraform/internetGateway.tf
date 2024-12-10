#Internet gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.Formiit-VPC.id

  tags = {
    Name = "Formiit-igw"
  }
}