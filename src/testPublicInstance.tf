
# Create a key pair for SSH access on EC2 instance
resource "aws_key_pair" "my_key" {
  key_name   = "my-key-pair"
  public_key = file("/mnt/c/Users/diamo/.ssh/test-aws/id_rsa.pub") # Path to public ssh key
}

# Create an EC2 instance
resource "aws_instance" "free_tier_public_instance" {
  ami           = "ami-02a0945ba27a488b7" # Amazon Linux 2 AMI ID for eu-north-1
  instance_type = "t3.micro"                     # Free-tier eligible instance type

  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "PublicFreeTierInstance"
  }

  # Root Block Device (free tier allows up to 30 GB of SSD storage)
  root_block_device {
    volume_type = "gp2"
    volume_size = 8 # Free tier limit for EBS is up to 30 GB
  }

  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
}


output "public_instance_id" {
  value = aws_instance.free_tier_public_instance.id
}


output "public_instance_ip" {
  value = aws_instance.free_tier_public_instance.public_ip
  sensitive = true
}
