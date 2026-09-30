variable "project_name" {
  description = "Nome do projeto, usado nas tags dos recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de implantação (ex: dev, staging, prod)"
  type        = string
}

variable "subnet_id" {
  description = "ID da sub-rede pública onde a instância EC2 será criada"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs dos security groups a serem associados à instância EC2"
  type        = list(string)
}

variable "db_host" {
  description = "Endereço do host do banco de dados"
  type        = string
}

variable "db_user" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_port" {
  description = "Porta do banco de dados"
  type        = number
  default     = 5432
}

variable "tags" {
  description = "Mapa de tags adicionais a serem aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}
