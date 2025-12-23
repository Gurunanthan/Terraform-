terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  
}

provider "aws" {
  region = var.region
}

variable "Environment" {
    default = "dev"
    type = string

}

variable "Instancename" {
    default = "From terraform"
    type = string
}

variable "Instance_use" {
    default = "terraform"
    # here intentionally left blank so that the typr of this variable can be any
}

variable "region" {
  type    = string
  default = "us-east-1"
}



locals {
    bucket_name = "this is from local value"
    instance_type = "t3.micro"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance_type

  tags = {
    Name = var.Instancename
    env = var.Environment
    instance_use = "${var.Instance_use}-${var.Environment}"
    bucket_associated = local.bucket_name
    region = var.region
  }
}
