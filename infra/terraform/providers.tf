terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Populate before running terraform init:
    # bucket = "felt-terraform-state-<account-id>"
    # key    = "felt/<env>/terraform.tfstate"
    # region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Felt"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
