resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  force_destroy = true

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_s3.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "data"
    yor_trace            = "71ace1fd-2502-40b3-a335-823d292e682d"
  }
}

resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_s3.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "data_object"
    yor_trace            = "69281c6b-3015-41ee-bd5b-a45517593096"
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  acl           = "private"
  force_destroy = true

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_s3.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "financials"
    yor_trace            = "8e4b9890-175c-4b2c-b213-d9c671ce469a"
  }
}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket = "${local.resource_prefix.value}-operations"
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_s3.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "operations"
    yor_trace            = "90b867e4-87e9-42fc-b9e8-ead34215060c"
  }
}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_s3.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "data_science"
    yor_trace            = "62810e51-5c16-4c7a-837b-de9db6dde1a3"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }
  force_destroy = true

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_s3.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "logs"
    yor_trace            = "cbfb4d74-0c52-4f96-910f-fcb463feee92"
  }
}
