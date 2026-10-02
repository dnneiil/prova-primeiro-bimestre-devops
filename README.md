# Prova Primeiro Bimestre - DevOps (API de Reservas TechNova)

**Nome:** Daniel Alves Pinheiro
**RA:** 6325213
**Curso:** DevOps

## Sobre o projeto

Este repositório tem a solução da prova do primeiro bimestre. É uma API de reservas feita com Node.js e Express, que guarda os dados em um banco PostgreSQL. A API roda em container com Docker, sobe localmente com Docker Compose e é publicada na AWS com Terraform, dividido em módulos.

Cada reserva tem os campos: id, cliente, data e status.

## Tecnologias

- Node.js e Express (API)
- PostgreSQL 16 (banco de dados)
- Docker e Docker Compose (containers)
- Terraform com módulos (infraestrutura como código)
- AWS Academy Learner Lab, região us-east-1 (VPC, EC2, RDS, Security Groups)
- S3 e DynamoDB (estado remoto do Terraform)
- Git e GitHub (versionamento, com Conventional Commits)
- Kiro e Claude (IA como copiloto)

## Rotas da API

| Método | Rota | O que faz |
|--------|------|-----------|
| POST | /reservas | Cria uma reserva |
| GET | /reservas | Lista todas as reservas |
| GET | /reservas/:id | Busca uma reserva (404 se não existir) |
| PUT | /reservas/:id | Atualiza uma reserva |
| DELETE | /reservas/:id | Remove uma reserva |
| GET | /health | Verifica se a API está no ar |

## Como rodar localmente (Docker Compose)

1. Clone o repositório:

```bash
git clone https://github.com/dnneiil/prova-primeiro-bimestre-devops.git
cd prova-primeiro-bimestre-devops
```

2. Crie o arquivo `.env` a partir do exemplo e coloque suas senhas:

```bash
cp .env.example .env
```

3. Suba a API e o banco com um comando:

```bash
docker compose up -d --build
docker compose ps
```

4. Teste:

```bash
curl http://localhost:3000/health
```

O banco usa um volume nomeado, então os dados continuam depois de reiniciar. Para parar: `docker compose down`.

## Como subir na AWS (Terraform)

Use as credenciais do AWS Learner Lab (AWS Details, AWS CLI) e a região us-east-1.

1. Crie o estado remoto: um bucket S3 com versionamento, criptografia e bloqueio de acesso público, e a tabela DynamoDB de lock (código em `infra/backend`). No Learner Lab o bucket foi configurado pela AWS CLI, porque o Lab bloqueia a leitura do object lock.
2. Informe a senha do banco por variável de ambiente, sem escrever no código:

```bash
export TF_VAR_db_password="sua-senha"
```

3. Rode na pasta `infra`:

```bash
cd infra
terraform init
terraform validate
terraform plan
terraform apply
```

4. Ao final, pegue a URL da API nos outputs (`api_url`).
5. Quando terminar, destrua tudo para não gastar créditos:

```bash
terraform destroy
```

## Estrutura de pastas
```



```
app/ API de Reservas (código, Dockerfile e .dockerignore)
docker-compose.yml API + PostgreSQL (ambiente local)
.env.example Exemplo de variáveis, sem senhas reais
infra/
modules/ vpc, security-group, ec2, rds
backend/ DynamoDB do estado remoto
main.tf, variables.tf, outputs.tf, providers.tf Composição dos módulos
evidencias/ Saídas de docker, terraform e testes da API
relatorio.md Relatório do processo com IA
prompts.md Prompts usados no Kiro


## Segurança

- Nenhuma senha no código: ela vem de variável de ambiente.
- O .gitignore bloqueia .env, *.tfstate, *.tfvars, .terraform/ e *.pem.
- O RDS fica em sub-rede privada, sem acesso público e criptografado, e só aceita a porta 5432 vinda do security group da EC2.
- Nenhum recurso IAM foi criado: foi usado o LabInstanceProfile.
