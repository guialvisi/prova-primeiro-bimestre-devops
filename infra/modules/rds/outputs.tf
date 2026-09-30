output "rds_endpoint" {
  description = "Endpoint do banco PostgreSQL RDS"
  value       = aws_db_instance.postgres.address
}

output "rds_port" {
  description = "Porta do PostgreSQL"
  value       = aws_db_instance.postgres.port
}

output "rds_id" {
  description = "ID da instancia RDS"
  value       = aws_db_instance.postgres.id
}

output "rds_arn" {
  description = "ARN da instancia RDS"
  value       = aws_db_instance.postgres.arn
}
