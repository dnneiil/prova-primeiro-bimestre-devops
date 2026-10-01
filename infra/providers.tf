terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tfstate-reservas-6325213"
    key            = "reservas/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-reservas"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Projeto  = "prova-devops"
      Ambiente = "lab"
      Managed  = "terraform"
    }
  }
}
