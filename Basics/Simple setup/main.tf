terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-3"
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}