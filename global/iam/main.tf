provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_user" "example" {
  # toset converts the var.user_names list into a set.
  # for_each supports sets and maps only when used on a resource.
  for_each = toset(var.user_names)
  name     = each.value
}
