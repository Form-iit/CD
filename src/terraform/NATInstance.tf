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

              # Configure debconf for non-interactive installation
              echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
              echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
              
              # Installing iptables
              export DEBIAN_FRONTEND=noninteractive
              sudo apt update
              sudo apt install -y iptables-persistent net-tools

              
              # Turning on IP Forwarding
              echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
              sudo sysctl -p
              
              # Flush nat rules
              sudo iptables -t nat -F

              # Getting the primary network interface
              INTERFACE=$(ip route get 8.8.8.8 | awk -- '{printf $5}')

              # Getting the private subnet CIDR
              PRIVATE_SUBNET_CIDR=${aws_subnet.private_subnet.cidr_block} 
              
              # Making a catchall rule for routing and masking the private IP
              sudo iptables -t nat -A POSTROUTING -o $INTERFACE -s $PRIVATE_SUBNET_CIDR -j MASQUERADE
              
              # Save iptables rules
              sudo netfilter-persistent save
              sudo systemctl enable netfilter-persistent
              sudo netfilter-persistent reload
              EOF

  tags = {
    Name = "NAT-Instance"
  }
}