output "state_bucket_name" {
  description = "Bucket S3 utilizado para armazenar o Terraform State"
  value       = "technova-reservas-tfstate-5367779"
}

output "dynamodb_table_name" {
  description = "Tabela DynamoDB utilizada para locking"
  value       = aws_dynamodb_table.terraform_locks.name
}