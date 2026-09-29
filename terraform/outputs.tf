output "ec2_public_ip" {
  description = "IP publico da EC2"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "Endpoint do PostgreSQL RDS"
  value       = module.rds.endpoint
}

output "api_url" {
  description = "URL publica da API de Reservas"
  value       = "http://${module.ec2.public_ip}:3000"
}
