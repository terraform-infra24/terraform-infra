terraform {
  backend "s3" {
    bucket         = "dcr-s3-bucket-for-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "R-dev-tf-lock-state"
  }
}