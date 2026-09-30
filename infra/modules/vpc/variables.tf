variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "technova-reservas"
}
