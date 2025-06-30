
terraform {
  cloud {

    organization = "rpatel-terraform-Labs"

    workspaces {
      name = "terra-refresh"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}


provider "aws" {
  region = "us-east-1"
}



resource "aws_vpc" "dev-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev-vpc"
  }
}


resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-igw"
  }
}


resource "aws_internet_gateway_attachment" "dev-igw" {
  internet_gateway_id = aws_internet_gateway.dev-igw.id
  vpc_id              = aws_vpc.dev-vpc.id
}
