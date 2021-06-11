provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "luca0x333-terraform-state"
    key    = "staging/services/webserver-cluster/terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "luca0x333-terraform-state-locks"
    encrypt        = true
  }
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-staging"
  db_remote_state_bucket = "luca0x333-terraform-state"
  db_remote_state_key    = "staging/services/services/data-store/mysql/terraform.tfstate"

  min_size = 2
  max_size = 2
}
