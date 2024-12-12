provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dev_s3" {
  bucket_prefix = "dev-"

  tags = {
    Environment          = "Dev"
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "simple_s3.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "dev_s3"
    yor_trace            = "8b64750c-e592-4cef-ab64-9322f5c7497b"
  }
}


