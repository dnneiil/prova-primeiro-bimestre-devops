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
# Data source — AMI Amazon Linux 2023 mais recente
# -----------------------------------------------------------------
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# -----------------------------------------------------------------
# EC2 Instance
# -----------------------------------------------------------------
resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = true
  iam_instance_profile        = "LabInstanceProfile"

  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Atualiza o sistema e instala dependências
    dnf update -y
    dnf install -y git

    # Instala o Docker
    dnf install -y docker
    systemctl enable docker
    systemctl start docker

    # Clona o repositório da API
    git clone https://github.com/dnneiil/prova-primeiro-bimestre-devops /opt/app

    # Constrói a imagem Docker a partir da pasta app
    docker build -t api-app /opt/app/app

    # Executa o contêiner com as variáveis de ambiente do banco de dados
    docker run -d \
      --name api-app \
      --restart unless-stopped \
      -p 3000:3000 \
      -e DB_HOST="${var.db_host}" \
      -e DB_USER="${var.db_user}" \
      -e DB_PASSWORD="${var.db_password}" \
      -e DB_NAME="${var.db_name}" \
      -e DB_PORT="${var.db_port}" \
      -e DB_SSL="true" \
      api-app
  EOF

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-ec2"
  })
}
