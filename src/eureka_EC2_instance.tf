# Create an EC2 instance
resource "aws_instance" "eureka_EC2" {
  ami           = "ami-02a0945ba27a488b7" # # Amazon Linux 2 AMI ID for eu-north-1
  instance_type = "t3.micro"              # Free-tier eligible instance type

  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.eureka_security_group.id]

  tags = {
    Name = "PrivateFreeTierInstance"
  }

  # Root Block Device (free tier allows up to 30 GB of SSD storage)
  root_block_device {
    volume_type = "gp2"
    volume_size = 8 # Free tier limit for EBS is up to 30 GB
  }

  subnet_id                   = aws_subnet.private_subnet.id
  associate_public_ip_address = false
}

output "eureka_instance_ip" {
  value = aws_instance.eureka_EC2.private_ip
}
