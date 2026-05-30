module "s3-module" {
  source = "git::https://github.com/terraform-infra24/terraform-s3-module.git?ref=v1.0"
  bucket_name = var.bucket
  env = var.env
}