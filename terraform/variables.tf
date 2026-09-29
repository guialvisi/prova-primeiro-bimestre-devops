variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuario administrador do PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Senha administrador do PostgreSQL"
  type        = string
  sensitive   = true
}
variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "technova-reservas"
}
variable "github_repository" {
  description = "Repositorio GitHub da API"
  type        = string
}
