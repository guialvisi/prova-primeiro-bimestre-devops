variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "Security Group utilizado pelo RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuario administrador do PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Senha administrador do PostgreSQL"
  type        = string
  sensitive   = true
}
