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

#
resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-example"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  skip_final_snapshot = true
  username            = "admin"
  password            = var.db_password
}
