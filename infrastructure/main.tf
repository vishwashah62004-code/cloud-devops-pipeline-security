provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "devops_security_demo" {
  #checkov:skip=CKV2_AWS_62:Event notifications are outside the scope of this CI/CD security demonstration
  #checkov:skip=CKV_AWS_18:Access logging requires an additional logging destination and is outside this demonstration scope
  #checkov:skip=CKV_AWS_144:Cross-region replication is outside the scope of this CI/CD security demonstration
  #checkov:skip=CKV_AWS_145:KMS-based encryption requires additional key-management configuration and is outside this demonstration scope

  bucket = "cloud-devops-security-demo-bucket"

  tags = {
    Name = "DevOps Security Demo"
  }
}

resource "aws_s3_bucket_public_access_block" "devops_security_demo" {
  bucket = aws_s3_bucket.devops_security_demo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "devops_security_demo" {
  bucket = aws_s3_bucket.devops_security_demo.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "devops_security_demo" {
  bucket = aws_s3_bucket.devops_security_demo.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "devops_security_demo" {
  bucket = aws_s3_bucket.devops_security_demo.id

  rule {
    id     = "cleanup"
    status = "Enabled"

    expiration {
      days = 365
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
