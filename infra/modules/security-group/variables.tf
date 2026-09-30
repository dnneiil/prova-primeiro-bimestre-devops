variable "project_name" {
  description = "Nome do projeto, usado nas tags dos recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de implantação (ex: dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde os security groups serão criados"
  type        = string
}

variable "tags" {
  description = "Mapa de tags adicionais a serem aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}
