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

  instance_type      = "t2.micro"
  ami                = "ami-07dc734dc14746eab"
  min_size           = 1
  max_size           = 2
  enable_autoscaling = false

  custom_tags = {
    Owner      = "team-sre"
    DeployedBy = "terraform"
  }
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  security_group_id = module.webserver_cluster.alb_security_group_id
  type              = "ingress"
  from_port         = 12345
  to_port           = 12345
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
