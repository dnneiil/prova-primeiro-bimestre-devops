locals {
  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

# -----------------------------------------------------------------
# DB Subnet Group — agrupa as sub-redes privadas para o RDS
# -----------------------------------------------------------------
resource "aws_db_subnet_group" "this" {
  name        = "${var.project_name}-${var.environment}-db-subnet-group"
  description = "Subnet group para o RDS do projeto ${var.project_name} em ${var.environment}"
  subnet_ids  = var.private_subnet_ids

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  })
}

# -----------------------------------------------------------------
# RDS Instance — PostgreSQL 16
# -----------------------------------------------------------------
resource "aws_db_instance" "this" {
  identifier        = "${var.project_name}-${var.environment}-rds"
  engine            = "postgres"
  engine_version    = "16"
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids

  publicly_accessible = false
  storage_encrypted   = true
  skip_final_snapshot = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-rds"
  })
}
