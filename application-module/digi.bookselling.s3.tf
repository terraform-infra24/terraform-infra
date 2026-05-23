module "s3-module" {
  source = "git::https://github.com/terraform-infra24/terraform-s3-module.git"
  bucket_name = var.bucket
  ent = var.env
}