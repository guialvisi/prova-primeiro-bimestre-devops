variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet publica onde a EC2 sera criada"
  type        = string
}

variable "security_group_id" {
  description = "ID do Security Group associado a EC2"
  type        = string
}

variable "db_host" {
  description = "Endpoint do RDS PostgreSQL"
  type        = string
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
}

variable "db_username" {
  description = "Usuario do banco PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Senha do banco PostgreSQL"
  type        = string
  sensitive   = true
}
