terraform {
  #-> Configure remote backend (e.g. - AWS S3 bucket)
  # backend "s3" {}

  #-> Configure local backend (local running only)
  backend "local" {
    path = "./terraform.tfstate"
  }
}
