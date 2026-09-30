# Prompts usados

## Prompt 1: API de Reservas

Crie em app/ uma API Node.js/Express com CRUD de reservas (POST, GET, GET /:id, PUT, DELETE em /reservas; 404 se não existir; validar campos obrigatórios cliente, data e status) usando pg e PostgreSQL. Inclua GET /health. Crie a tabela automaticamente ao iniciar. Configure por variáveis de ambiente DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT. Inclua package.json.

## Prompt 2: Dockerfile

Crie app/Dockerfile multi-stage (node:20-alpine) rodando com usuário não-root, expondo a porta 3000, e app/.dockerignore ignorando node_modules e .env. O comando de início é npm start.

**Resultado:** (preencho depois)

## Prompt 3: Docker Compose

Crie docker-compose.yml na raiz com dois serviços: api (build ./app, porta 3000) e postgres:16. Use volume nomeado, rede bridge customizada, healthcheck no postgres e depends_on com service_healthy. Crie também .env.example sem senhas reais.

**Resultado:** (preencho depois)