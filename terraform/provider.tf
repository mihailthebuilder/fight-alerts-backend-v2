terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11"
    }
  }

  backend "s3" {
    bucket = "terraform-backends-mm"
    key    = "fight-alerts-backend"
    region = "eu-west-2"
  }
}

provider "aws" {
  region  = var.region
  profile = "default"

  default_tags {
    tags = var.resource_tags
  }
}