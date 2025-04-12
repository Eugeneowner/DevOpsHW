provider "aws" {
  region  = "eu-central-1"
  profile = "mfa"
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-danit-devops-7"
    key     = "eugene/terraform.tfstate"
    region  = "eu-central-1"
    profile = "mfa"
  }
}