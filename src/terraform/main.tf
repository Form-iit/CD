terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.79.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = "eu-north-1" # Replace with your desired region
}

# Create a key pair for SSH access on EC2 instances
resource "aws_key_pair" "my_key" {
  key_name   = "my-key-pair"
  public_key = var.ec2_public_SSH_key 
}
