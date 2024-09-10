terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket = "dolfined-team2024"
    key = "HA-3tier/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {

  profile = "terraform-dev"
  region  = "us-east-1"

}



