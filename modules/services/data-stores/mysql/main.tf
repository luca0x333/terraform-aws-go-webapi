resource "aws_db_instance" "example" {
  identifier_prefix   = var.db_identifier
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = var.db_instance_type
  name                = var.db_name
  skip_final_snapshot = true
  username            = var.db_admin
  password            = var.db_password
}
