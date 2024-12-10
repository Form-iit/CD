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