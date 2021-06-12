provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "luca0x333-terraform-state"
    key    = "staging/services/data-stores/mysql/terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "luca0x333-terraform-state-locks"
    encrypt        = true
  }
}

module "rds_instance" {
  source = "github.com/luca0x333/terraform-modules//data-stores//mysql?ref=v0.0.2"

  db_identifier    = "rds-staging-example"
  db_name          = "db_staging"
  db_admin         = "admin"
  db_password      = var.db_password
  db_instance_type = "db.t2.micro"
}
