# Create a security group for EC2 instance
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow-ssh"
  vpc_id      = aws_vpc.Formiit-VPC.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows access from any IP (restrict for security in production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}