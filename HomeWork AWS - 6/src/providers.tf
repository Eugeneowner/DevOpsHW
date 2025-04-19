provider "aws" {
  profile = "mfa"
  region  = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-danit-devops-7"
    key     = "rzayats/terraform.tfstate"
    region  = "eu-central-1"
    profile = "mfa"
  }
}
