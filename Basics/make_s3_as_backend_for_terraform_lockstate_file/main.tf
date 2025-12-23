terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "do-not-delete-it-is-for-terraformstate-file-backend"
    key    = "dev/make_s3_as_backend_for_terraform_lockstate_file"
    region = "ap-northeast-3"
    use_lockfile = true
    encrypt = true
  }
}

provider "aws" {
  region = "ap-northeast-3"
}



# id=do-not-delete-it-is-for-terraformstate-file-backend has been deleted