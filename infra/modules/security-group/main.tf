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
# Security Group — EC2
# -----------------------------------------------------------------
resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-${var.environment}-ec2-sg"
  description = "Security group para instancias EC2: SSH e aplicacao"
  vpc_id      = var.vpc_id

  # SSH
  ingress {
    description = "SSH de qualquer origem"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Aplicacao Node.js
  ingress {
    description = "Aplicacao na porta 3000 de qualquer origem"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Saida totalmente liberada
  egress {
    description = "Saida liberada para qualquer destino"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-ec2-sg"
  })
}

# -----------------------------------------------------------------
# Security Group — RDS
# -----------------------------------------------------------------
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group para o RDS: PostgreSQL apenas a partir da EC2"
  vpc_id      = var.vpc_id

  # PostgreSQL somente a partir do SG da EC2 (sem CIDR aberto)
  ingress {
    description     = "PostgreSQL originado apenas do security group da EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  # Sem regra de saida explicita — AWS bloqueia tudo por padrao
  # (mantenha o comportamento restritivo para o banco)

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-rds-sg"
  })
}
