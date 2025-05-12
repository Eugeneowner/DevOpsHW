terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "mfa"
}

resource "aws_s3_bucket" "eugene_bucket" {
  bucket        = "eugene-sp3"
  force_destroy = true

  tags = {
    Name  = "eugene bucket"
    Owner = var.owner
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks-sp3"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name  = "terraform-locks"
    Owner = var.owner
  }
}