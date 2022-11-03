terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "kc-terraform-state-dev"
    key    = "dev/terraform.tfstate"
    dynamodb_table = "terraform_state"
    region = "us-east-1"
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
      env                   = "dev"
    }
  }  
}
