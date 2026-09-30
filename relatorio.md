# Relatório do Processo - API de Reservas TechNova

**Daniel alves pinheiro**nome 
**6325213:**  RA
**Ferramentas de IA utilizadas:** Kiro (para gerar código) e Claude (como guia passo a passo)

## Questão 1 - A Jornada Completa (Aulas 01 a 07)

Eu sou iniciante em DevOps, então segui a ordem sugerida no enunciado: primeiro o Git, depois a aplicação, o Docker, o Docker Compose e, por último, a AWS com Terraform. Comecei pelo Git (Aula 01) porque ele registra tudo o que faço desde o início. Criei a pasta do projeto, o .gitignore, o README com meu nome e RA e fiz o primeiro commit. Depois criei o repositório público no GitHub e enviei os arquivos.

Em seguida criei uma feature branch chamada feat/api-reservas, para não mexer direto na main. Nela o Kiro gerou a API Node.js/Express com o CRUD de reservas e a conexão com o PostgreSQL. Usei commits convencionais (feat:, docs:, fix:) para deixar o histórico organizado.

A Aula 01 também aparece no Dockerfile, que coloca a API dentro de um contêiner com build em duas etapas e usuário que não é root. Na Aula 02, usei o Docker Compose para subir a API e o PostgreSQL com um único comando, com volume nomeado para não perder os dados, rede própria, healthcheck no banco e depends_on esperando o banco ficar saudável.

Fiz essa ordem porque cada etapa depende da anterior: não dá para colocar na nuvem uma aplicação que ainda não funciona no meu computador. Testei tudo localmente antes de partir para a AWS.

[COMPLETAR depois do Terraform: contar as Aulas 03 a 07, ou seja, o Terraform, a VPC, os security groups, a EC2, o RDS, os módulos, o estado remoto com S3 e DynamoDB e onde cada uma apareceu. Mínimo de 10 linhas no total.]

## Questão 2 - O Processo com IA como Copiloto

Usei duas ferramentas. O Kiro foi usado dentro do editor para gerar o código (API, Dockerfile e docker-compose). O Claude foi usado no chat como guia, para me explicar os passos e os erros do terminal, porque eu me perdi várias vezes.

No Kiro criei um arquivo de steering (.kiro/steering/regras.md) com as regras do projeto, como região us-east-1 e não criar recursos IAM, para não repetir isso em todo prompt. Pedi a API em um único prompt, no modo normal (não Spec), para gastar pouco crédito. Foram apenas 0,86 crédito de 50. Guardei todos os prompts no arquivo prompts.md.

A IA gerou bem a estrutura da API, as rotas com 404 e 400 e o docker-compose. Mas ela errou em uma coisa: o Dockerfile usava npm ci, que exige um package-lock.json, e esse arquivo não existia. O build falhou e eu troquei manualmente para npm install --omit=dev. Outro problema foi o comando curl, que funciona no Linux mas quebrou o JSON no PowerShell do Windows. Usei Invoke-RestMethod no lugar.

Comparando com fazer tudo manualmente, a IA economizou muito tempo escrevendo os arquivos. Por outro lado, atrapalhou quando o código tinha um detalhe que eu não sabia identificar e precisei entender a mensagem de erro para corrigir. Como iniciante, também me atrapalhei por não saber onde colar cada coisa (prompt.md, chat do Kiro ou terminal).

[COMPLETAR depois do Terraform: contar como foi pedir os módulos Terraform ao Kiro, quais prompts usei, o que veio errado e o que corrigi.]

## Questão 3 - Infraestrutura, Segurança e Learner Lab

[COMPLETAR depois de fazer a AWS. Explicar em pelo menos 10 linhas: a arquitetura que eu criei (VPC, sub-redes públicas e privadas em 2 AZs, EC2, RDS); por que o RDS fica na sub-rede privada (não fica exposto na internet, só a EC2 acessa pela porta 5432) e a EC2 na pública (precisa receber acesso externo na porta 3000); como usei LabRole e LabInstanceProfile em vez de criar IAM; e as restrições do Learner Lab que encontrei (credenciais temporárias com token, região us-east-1, sem criar usuários ou funções).]

## Questão 4 - Validação e Responsabilidade

[COMPLETAR antes do terraform apply, com o checklist que eu realmente aplicar: existe algum recurso aws_iam_*? o RDS está com publicly_accessible=false e storage_encrypted=true? a porta 5432 só aceita o SG da EC2? há senha escrita no código? as tags e a região estão certas?]

Já vivi na prática o risco de aceitar código da IA sem revisar: o Dockerfile gerado tinha um erro (npm ci sem package-lock.json) que só descobri porque testei o build. Se eu tivesse aceitado sem testar, a entrega teria um contêiner que não sobe. Na infraestrutura o risco é maior, pois um erro pode expor o banco de dados ou gastar os créditos do Lab.

A evolução Git → Docker → Compose → Terraform me ensinou a testar em pequenos passos, a versionar cada mudança e a só avançar quando a etapa anterior funciona.

[COMPLETAR: terminar com 10 linhas, incluindo como validei a infraestrutura na AWS.]