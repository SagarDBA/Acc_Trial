output "database_endpoint" {
  description = "The connection endpoint for the database"
  value       = module.postgres_db.db_instance_endpoint
}

output "database_name" {
  description = "The name of the database"
  value       = module.postgres_db.db_instance_name
}

output "database_port" {
  description = "The database port"
  value       = module.postgres_db.db_instance_port
}