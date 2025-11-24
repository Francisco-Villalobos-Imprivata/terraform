terraform {
  backend "gcs" {
    bucket = "REWRITE_BACKEND"
    prefix = "REWRITE_PREFIX"
  }
}