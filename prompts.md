# Prompts usados

## Prompt 1: API de Reservas

Crie em app/ uma API Node.js/Express com CRUD de reservas (POST, GET, GET /:id, PUT, DELETE em /reservas; 404 se não existir; validar campos obrigatórios cliente, data e status) usando pg e PostgreSQL. Inclua GET /health. Crie a tabela automaticamente ao iniciar. Configure por variáveis de ambiente DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT. Inclua package.json.

**Resultado:** O Kiro criou a API com todas as rotas de uma vez só (0,86 crédito). Quando fui testar, o curl não funcionou no PowerShell do Windows porque o JSON chegou quebrado na API. Troquei para o Invoke-RestMethod e aí funcionou. A reserva da Ana foi gravada no PostgreSQL..

## Prompt 2: Dockerfile

Crie app/Dockerfile multi-stage (node:20-alpine) rodando com usuário não-root, expondo a porta 3000, e app/.dockerignore ignorando node_modules e .env. O comando de início é npm start.

**Resultado:** O Kiro colocou `npm ci` no Dockerfile, mas o build deu erro porque não existia o package-lock.json. Eu li o erro e troquei por `npm install --omit=dev`. Depois o build funcionou..

## Prompt 3: Docker Compose

Crie docker-compose.yml na raiz com dois serviços: api (build ./app, porta 3000) e postgres:16. Use volume nomeado, rede bridge customizada, healthcheck no postgres e depends_on com service_healthy. Crie também .env.example sem senhas reais.

**Resultado:** O docker compose subiu com a API e o banco healthy. Depois, olhando o resultado do merge, vi que o .env tinha ido para o GitHub. Descobri que eu tinha criado o arquivo com o nome errado (.gitgnore, faltou o "i"), então o Git ignorava a regra. Renomeei para .gitignore e tirei o .env do Git com `git rm --cached .env`. Esse erro foi meu, não da IA.

## Prompt 4: Módulo VPC

Em infra/modules/vpc, crie um módulo Terraform com VPC (10.0.0.0/16), 2 sub-redes públicas e 2 privadas em 2 AZs de us-east-1, internet gateway e route table pública. Crie variables.tf, main.tf e outputs.tf (ids da vpc e das sub-redes). Tags em todos os recursos.

**Resultado:** O Kiro criou o módulo da VPC com os três arquivos (main.tf, variables.tf e outputs.tf). Ainda vou validar com terraform validate antes de usar.