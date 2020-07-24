# s3 variables
variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the bucket to create"
}

variable "bucket_acl" {
  description = "ACL for S3 bucket: private, public-read, public-read-write, etc"
  default     = "Public"
}

variable "kms_key_arn" {
  description = "ARN of the KMS key that encrypts the bucket"
}

# Sentinel variables

variable "tfe_vcs_oauth_id" {
  type        = string
  description = "VCS Repo token id needed to associate policy set to workspace"
}

variable "tfe_host_name" {
  description = "host_name for ptfe"
  default     = "tfe.tlzdemo.net"
}
variable "tfe_org_token" {
  type        = string
  description = "ORG token for constructing sentinel policies and associating to workspace"
}