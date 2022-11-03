terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = "us-east-1"
  default_tags {
    tags = {
      use                   = "learn_terraform"
      learn_terraform       = "use"
    }
  }  
}

resource "aws_s3_bucket" "kc-terraform-state-dev" {
  bucket = "kc-terraform-state-dev"
}

resource "aws_s3_bucket_versioning" "kc-terraform-state-dev" {
  bucket = aws_s3_bucket.kc-terraform-state-dev.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "kc-terraform-state-dev" {
  bucket = aws_s3_bucket.kc-terraform-state-dev.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
    name           = "terraform_state"
    billing_mode = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

