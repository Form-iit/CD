resource "aws_instance" "Config_server_EC2" {
  ami           = "ami-075449515af5df0d1" # Ubuntu server 24.04 LTS AMI ID for eu-north-1
  instance_type = "t3.micro"              # Free-tier eligible instance type

  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.config_server_security_group.id]

  tags = {
    Name = "Config-server"
  }

  # Root Block Device (free tier allows up to 30 GB of SSD storage)
  root_block_device {
    volume_type = "gp2"
    volume_size = 8 # Free tier limit for EBS is up to 30 GB
  }

  subnet_id                   = aws_subnet.private_subnet.id
  associate_public_ip_address = false

  user_data = <<-EOF
            #!/bin/bash
            hostnamectl set-hostname config-service
            EOF
}

output "config_server_instance_details" {
  value = {
    private_ip = aws_instance.Config_server_EC2.private_ip
    hostname  = "config-service"
  }
}
