terraform {
  backend "s3" {
    bucket       = "bayers-terraform-state-bucket"
    key          = "B5-uc-1/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}