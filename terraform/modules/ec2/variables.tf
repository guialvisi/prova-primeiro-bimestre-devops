variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet publica onde a EC2 sera criada"
  type        = string
}

variable "ec2_security_group_id" {
  description = "Security Group da EC2"
  type        = string
}

variable "ami_id" {
  description = "AMI utilizada pela EC2"
  type        = string
}
variable "db_host" {
  description = "Endpoint do RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
}

variable "db_username" {
  description = "Usuario do PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Senha do PostgreSQL"
  type        = string
  sensitive   = true
}
variable "github_repository" {
  description = "URL HTTPS do repositorio GitHub"
  type        = string
}
