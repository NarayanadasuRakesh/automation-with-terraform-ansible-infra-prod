terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
  backend "s3" {
    bucket         = "roboshop-terraform-prod"
    key            = "vpn"
    region         = "us-east-1"
    dynamodb_table = "roboshop-terraform-prod"
  }
}

provider "aws" {
  # Configuration options
}
