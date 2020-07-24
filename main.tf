terraform {
  required_version = ">= 0.12.6"
}

provider "aws" {
  region = var.aws_region
}

# Sentinel Provider

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

output "sse_algorithm" {
  value = aws_s3_bucket.bucket.server_side_encryption_configuration[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm
}
