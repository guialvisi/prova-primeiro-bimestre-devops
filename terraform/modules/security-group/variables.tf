variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "technova-reservas"
}

variable "ssh_cidr" {
  description = "CIDR autorizado para SSH"
  type        = string
  default     = "0.0.0.0/0"
}
