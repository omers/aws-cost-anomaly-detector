terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }

}

provider "aws" {
  region = var.region
  default_tags {
    tags = var.resource_tags
  }
}