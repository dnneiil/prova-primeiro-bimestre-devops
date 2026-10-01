terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket de state (criado via AWS CLI)"
  type        = string
}

variable "table_name" {
  description = "Tabela DynamoDB para locking"
  type        = string
  default     = "terraform-locks-reservas"
}

locals {
  tags = {
    Projeto  = "prova-devops"
    Ambiente = "lab"
    Managed  = "terraform"
  }
}

resource "aws_dynamodb_table" "locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

output "bucket_name" {
  value = var.bucket_name
}

output "dynamodb_table" {
  value = aws_dynamodb_table.locks.name
}
