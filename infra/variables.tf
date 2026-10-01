variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "reservas"
}

variable "environment" {
  description = "Ambiente"
  type        = string
  default     = "lab"
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuario do banco"
  type        = string
  default     = "reservas_admin"
}

variable "db_password" {
  description = "Senha do banco (passada por variavel de ambiente, nunca no Git)"
  type        = string
  sensitive   = true
}
