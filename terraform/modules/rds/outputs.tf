output "endpoint" {
  description = "Endpoint do PostgreSQL RDS"
  value       = aws_db_instance.postgres.address
}

output "port" {
  description = "Porta do PostgreSQL"
  value       = aws_db_instance.postgres.port
}

output "db_name" {
  description = "Nome do banco"
  value       = aws_db_instance.postgres.db_name
}

output "db_instance_id" {
  description = "ID da instancia RDS"
  value       = aws_db_instance.postgres.id
}

