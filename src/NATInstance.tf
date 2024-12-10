# NAT Instance using Amazon Linux 2 (Free tier eligible)
resource "aws_instance" "nat_instance" {
  ami           = "ami-02a0945ba27a488b7" # Using Amazon Linux 2 (free tier eligible)
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.natSecGrp.id]

  # Disable source/dest check for NAT
  source_dest_check = false

  # Add this line to ensure a public IP
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash

              # Updating the system
              sudo yum update -y

              # Installing iptables
              sudo yum install iptables-services -y 

              # Turning on IP Forwarding
              echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
              sudo sysctl -p

              # Flush nat rules
              iptables -t nat -F
              
              # Making a catchall rule for routing and masking the private IP
              sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.0.1.0/24 -j MASQUERADE
              EOF

  tags = {
    Name = "NAT-Instance"
  }
}

output "nat_instance_id" {
  value = aws_instance.nat_instance.id
}


output "nat_instance_ip" {
  value     = aws_instance.nat_instance.public_ip
}
