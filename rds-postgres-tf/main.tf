module "postgres_db" {
  source = "./modules/rds"

  identifier = var.db_identifier
  db_name    = var.db_name
  username   = var.db_username
  password   = var.db_password

  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  multi_az           = var.multi_az

  tags = var.default_tags
}