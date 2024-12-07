
# VPC
resource "aws_vpc" "Formiit-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Formiit-VPC"
  }
}

output "vpc_id" {
  value = aws_vpc.Formiit-VPC.id
}


output "vpc_cidr_block" {
  value = aws_vpc.Formiit-VPC.cidr_block
}