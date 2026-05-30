module "bookselling" {
  source = "../../application_module"
  bucket = var.dev_bucket
  env    = var.env
}