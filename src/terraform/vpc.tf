
# VPC
resource "aws_vpc" "Formiit-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Formiit-VPC"
  }
}