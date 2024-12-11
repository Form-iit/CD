terraform {
  cloud { 
    organization = "Form-iit" 

    workspaces { 
      name = "github-actions-pipeline" 
    } 
  } 

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.79.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = var.aws_region
}

# Create a key pair for SSH access on EC2 instances
resource "aws_key_pair" "my_key" {
  key_name   = "my-key-pair"
  public_key = var.ec2_public_SSH_key 
}
