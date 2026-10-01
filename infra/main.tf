locals {
  tags = {
    Projeto  = var.project_name
    Ambiente = var.environment
  }
}

module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  tags                 = local.tags
}

module "security_group" {
  source = "./modules/security-group"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  tags         = local.tags
}

module "rds" {
  source = "./modules/rds"

  project_name           = var.project_name
  environment            = var.environment
  private_subnet_ids     = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.security_group.rds_security_group_id]
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  tags                   = local.tags
}

module "ec2" {
  source = "./modules/ec2"

  project_name           = var.project_name
  environment            = var.environment
  subnet_id              = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids = [module.security_group.ec2_security_group_id]
  db_host                = module.rds.address
  db_user                = var.db_username
  db_password            = var.db_password
  db_name                = var.db_name
  db_port                = module.rds.port
  tags                   = local.tags
}
