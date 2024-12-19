# NAT Instance using Amazon Linux 2 (Free tier eligible)
resource "aws_instance" "nat_instance" {
  ami           = "ami-075449515af5df0d1" # Ubuntu server 24.04 LTS AMI ID for eu-north-1
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.natSecGrp.id]
  key_name               = aws_key_pair.my_key.key_name
  
  # Disable source/dest check for NAT
  source_dest_check = false

  # Add this line to ensure a public IP
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              
              # Updating the system
              sudo apt-get update && sudo apt-get upgrade -y
              
              # Installing iptables
              sudo apt-get install -y iptables-persistent
              
              # Turning on IP Forwarding
              echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
              sudo sysctl -p
              
              # Flush nat rules
              sudo iptables -t nat -F
              
              # Making a catchall rule for routing and masking the private IP
              sudo iptables -t nat -A POSTROUTING -o eth0 -s 10.0.1.0/24 -j MASQUERADE
              
              # Save iptables rules
              sudo netfilter-persistent save
              sudo netfilter-persistent reload
              EOF

  tags = {
    Name = "NAT-Instance"
  }
}