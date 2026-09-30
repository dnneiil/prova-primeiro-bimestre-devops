variable "project_name" {
  description = "Nome do projeto, usado nas tags dos recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de implantação (ex: dev, staging, prod)"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs das sub-redes privadas para o DB subnet group"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs dos security groups a serem associados à instância RDS"
  type        = list(string)
}

variable "db_name" {
  description = "Nome do banco de dados a ser criado na instância RDS"
  type        = string
}

variable "db_username" {
  description = "Usuário administrador do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do usuário administrador do banco de dados"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  description = "Tamanho do armazenamento alocado para a instância RDS (em GB)"
  type        = number
  default     = 20
}

variable "instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "tags" {
  description = "Mapa de tags adicionais a serem aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}
