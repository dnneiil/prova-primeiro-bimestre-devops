# Entrega - Prova do Primeiro Bimestre (DevOps)

**Aluno:** Daniel Alves Pinheiro
**RA:** 6325213
**Data:** 01/10/2026
**Ferramenta de IA utilizada:** Kiro e Claude

## Repositório do Projeto

- URL: https://github.com/dnneiil/prova-primeiro-bimestre-devops

## Checklist de Evidências

- [x] Repositório público com README (nome + RA) e .gitignore
- [x] Mínimo de 6 commits com Conventional Commits + feature branch
- [x] API com CRUD completo de reservas (POST, GET, GET/:id, PUT, DELETE) + /health
- [x] Rotas de CRUD gravando no banco PostgreSQL (não em memória)
- [x] Dockerfile funcional da API de Reservas
- [x] docker-compose.yml (API + PostgreSQL) subindo com um comando
- [x] Terraform modularizado (vpc, security-group, ec2, rds)
- [x] RDS PostgreSQL provisionado nas subnets privadas (banco da API na nuvem)
- [x] Remote State configurado (S3 + DynamoDB)
- [x] Uso de LabRole/LabInstanceProfile (sem criar IAM próprio)
- [x] terraform validate e terraform plan sem erros
- [x] relatorio.md completo (4 questões)
- [x] Recursos da AWS destruídos após as evidências (ver observação abaixo)

## Observação sobre o destroy

Ao final, o terraform destroy não funcionou: o bucket S3 do state remoto não existia mais, então o Terraform não encontrou o state. Para não gastar créditos, apaguei os recursos pela AWS CLI (EC2, RDS, security groups, subnets, tabela de rotas, internet gateway, VPC e a tabela DynamoDB) e confirmei que não restou nada.

## Evidências

Os arquivos estão na pasta evidencias/ do repositório:

- docker-build.txt: build da imagem Docker
- compose-ps.txt: docker compose ps com API e banco rodando
- terraform-plan.txt: plano do Terraform (14 recursos)
- terraform-output.txt: IP da EC2, endpoint do RDS e URL da API
- api-aws.txt e api-aws-resumo.txt: testes do CRUD completo na AWS (RDS)

Outros arquivos: relatorio.md (relatório com as 4 questões) e prompts.md (prompts usados no Kiro).

