provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "luca0x333-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "luca0x333-terraform-state-locks"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "luca0x333-terraform-state"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  hash_key     = "LockID"
  name         = "luca0x333-terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

