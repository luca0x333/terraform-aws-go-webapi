terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "eu-west-2"

  version = "~> 2.0"
}

module "asg" {
  source = "../../modules/cluster/asg-rolling-deploy"

  cluster_name  = var.cluster_name
  ami           = "ami-07dc734dc14746eab"
  instance_type = "t2.micro"

  min_size           = 1
  max_size           = 1
  enable_autoscaling = false

  subnet_ids = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
