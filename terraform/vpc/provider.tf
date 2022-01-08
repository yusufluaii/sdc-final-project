provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
  bucket = "luai-terraform-state"
  encrypt = true
  region = "ap-southeast-1"
  key = "main_vpc.tfstate"
  }
}