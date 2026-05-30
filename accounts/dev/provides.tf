terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.40.0, < 6.41.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}