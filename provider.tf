terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket = "dolfined-team2025"
    key = "pro3/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {

  profile = "terraform-dev"
  region  = "us-east-1"

}



