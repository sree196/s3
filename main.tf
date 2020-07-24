terraform {
  required_version = ">= 0.12.6"
}

provider "aws" {
  region = var.aws_region
}

# Sentinel Provider
provider "tfe" {
  version  = "~> 0.11.0"
  hostname = var.tfe_host_name
  token    = var.tfe_org_token
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    name             = "sriteja"
    Owner            = "sritej@amazon.com"
  }
}

# Consuming the Sentinel module for Core baseline
module "sentinal" {
  source             = "app.terraform.io/Sentinal/sentinal/tfe"
  version            = "~> 2.0.0"
  tfe_organization   = "TLZ-Demo"
  tfe_workspace      = "S3"
  tfe_policies_path  = "/"
  tfe_vcs_identifier = "sree196/terraform-tfe-sentinal"
  tfe_oauth_token_id = var.tfe_vcs_oauth_id
}


output "sse_algorithm" {
  value = aws_s3_bucket.bucket.server_side_encryption_configuration[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm
}
