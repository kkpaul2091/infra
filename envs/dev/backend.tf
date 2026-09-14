terraform {
  backend "s3" {
    bucket       = "kkp-test-bkt-v0" # Replace with your S3 bucket name
    key          = "envs/dev/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true # S3 native locking (Terraform >= 1.15)
  }
}

# Added by KKP

