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

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "do-not-delete-it-is-for-terraformstate-file-backend"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# the bucket has been deleted
