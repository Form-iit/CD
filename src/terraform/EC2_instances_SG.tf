# Create a security group for EC2 instance
resource "aws_security_group" "api-gw-sg" {
  name_prefix = "api-gw-sg"
  vpc_id      = aws_vpc.Formiit-VPC.id

  ingress {
    description = "Allow inbound SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "Allow inbound http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "Allow API Gateway port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Be cautious with this in production
  }

  ingress {
    description = "Allow inbound https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "Allow inbound icmp"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "eureka_security_group" {
  name_prefix = "eureka-sg"
  vpc_id      = aws_vpc.Formiit-VPC.id

  ingress {
    description = "SSH from public subnet"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups =  [aws_security_group.api-gw-sg.id]
  }

  ingress {
    description = "Eureka server ports from public subnet"
    from_port   = 8761
    to_port     = 8763
    protocol    = "tcp"
    security_groups = [ aws_security_group.api-gw-sg.id, aws_security_group.config_server_security_group.id ]
  }

  ingress {
    description = "ICMP from private subnet"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_subnet.private_subnet.cidr_block]  # Add for troubleshooting
  }

  # Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "config_server_security_group" {
  name_prefix = "config-server-sg"
  vpc_id      = aws_vpc.Formiit-VPC.id

  ingress {
    description = "SSH from public subnet"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups =  [aws_security_group.api-gw-sg.id]
  }

  ingress {
    description = "Config server ports from public subnet"
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    security_groups = [ aws_security_group.api-gw-sg.id ]
  }

  ingress {
    description = "ICMP from private subnet"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_subnet.private_subnet.cidr_block]  # Add for troubleshooting
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}