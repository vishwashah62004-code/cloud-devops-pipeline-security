provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "devops_security_demo" {
  bucket = "cloud-devops-security-demo-bucket"

  tags = {
    Name = "DevOps Security Demo"
  }
}
