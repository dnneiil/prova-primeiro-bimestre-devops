# Relatório do Processo - API de Reservas TechNova   

# Nome: Daniel Alves Pinheiro   

# 

# RA: 6325213   

# 

# Ferramentas de IA utilizadas: Kiro (para gerar código) e Claude (como guia passo a passo)   

# 

# Questão 1 - A Jornada Completa (Aulas 01 a 07)   

# Eu sou iniciante em DevOps, então segui a ordem sugerida no enunciado: primeiro o Git, depois a aplicação, o Docker, o Docker Compose e, por último, a AWS com Terraform. Comecei pelo Git (Aula 01) porque ele registra tudo o que faço desde o início. Criei a pasta do projeto, o .gitignore, o README com meu nome e RA e fiz o primeiro commit. Depois criei o repositório público no GitHub e enviei os arquivos.   

# 

# Em seguida criei uma feature branch chamada feat/api-reservas, para não mexer direto na main. Nela o Kiro gerou a API Node.js/Express com o CRUD de reservas e a conexão com o PostgreSQL. Usei commits convencionais (feat:, docs:, fix:) para deixar o histórico organizado.   

# 

# A Aula 01 também aparece no Dockerfile, que coloca a API dentro de um contêiner com build em duas etapas e usuário que não é root. Na Aula 02, usei o Docker Compose para subir a API e o PostgreSQL com um único comando, com volume nomeado para não perder os dados, rede própria, healthcheck no banco e depends\_on esperando o banco ficar saudável.   

# 

# Fiz essa ordem porque cada etapa depende da anterior: não dá para colocar na nuvem uma aplicação que ainda não funciona no meu computador. Testei tudo localmente antes de partir para a AWS.   

# 

# Depois fui para a AWS com Terraform (Aulas 03 a 06), em uma nova branch chamada feat/infra. Em vez de escrever tudo em um único arquivo, estruturei a infraestrutura de forma modular. Criei o módulo vpc (com sub-redes públicas e privadas em duas AZs), o módulo security-group (regras de acesso), o módulo ec2 (instância para rodar a aplicação) e o módulo rds (banco de dados PostgreSQL).

# 

# Para o estado remoto, criei um bucket S3 com criptografia e versionamento, além de uma tabela DynamoDB para controle de lock do estado. Em seguida, fiz a composição dos módulos interligando as saídas e entradas (como o ID da VPC e as credenciais do banco injetadas no user\_data da EC2). A Aula 07 (IA como copiloto) perpassou todo o processo, pois usei o Kiro para acelerar a escrita das configurações do Terraform e o Claude para diagnosticar erros no terminal. Ao final, rodei o terraform plan (14 recursos) e apliquei as mudanças, garantindo a paridade entre o ambiente local e o de nuvem.

# 

# Questão 2 - O Processo com IA como Copiloto

# Usei duas ferramentas. O Kiro foi usado dentro do editor para gerar o código (API, Dockerfile e docker-compose). O Claude foi usado no chat como guia, para me explicar os passos e os erros do terminal, porque eu me perdi várias vezes.   

# 

# No Kiro criei um arquivo de steering (.kiro/steering/regras.md) com as regras do projeto, como região us-east-1 e não criar recursos IAM, para não repetir isso em todo prompt. Pedi a API em um único prompt, no modo normal (não Spec), para gastar pouco crédito. Foram apenas 0,86 crédito de 50. Guardei todos os prompts no arquivo prompts.md.   

# 

# A IA gerou bem a estrutura da API, as rotas com 404 e 400 e o docker-compose. Mas ela errou em uma coisa: o Dockerfile usava npm ci, que exige um package-lock.json, e esse arquivo não existia. O build falhou e eu troquei manualmente para npm install --omit=dev. Outro problema foi o comando curl, que funciona no Linux mas quebrou o JSON no PowerShell do Windows. Usei Invoke-RestMethod no lugar.   

# 

# Na etapa do Terraform, pedi ao Kiro cada módulo separadamente (vpc, security-group, ec2 e rds). Embora as regras do steering estivessem ativas, a IA gerou o user\_data da EC2 sem incluir a variável de ambiente DB\_SSL, fazendo com que a API não conseguisse se comunicar com o banco RDS (que exige conexão segura por padrão no PostgreSQL 16). Identifiquei a falha ao analisar as variáveis de conexão da API e ajustei manualmente a configuração, adicionando DB\_SSL=true no arquivo de inicialização do servidor.

# 

# Comparando com fazer tudo manualmente, a IA economizou muito tempo escrevendo os arquivos. Por outro lado, atrapalhou quando o código tinha um detalhe que eu não sabia identificar e precisei entender a mensagem de erro para corrigir. Como iniciante, também me atrapalhei por não saber onde colar cada coisa (prompts, comandos do Kiro ou terminal).   

# 

# Questão 3 - Infraestrutura, Segurança e Learner Lab

# A arquitetura que criei na AWS (região us-east-1) é composta por uma VPC personalizada contendo duas sub-redes públicas e duas sub-redes privadas distribuídas em duas zonas de disponibilidade (us-east-1a e us-east-1b). A rede pública conta com um Internet Gateway e uma tabela de roteamento associada para liberar o tráfego externo.

# 

# Na sub-rede pública fica hospedada a instância EC2 (t2.micro), que executa a aplicação via Docker na porta 3000 e aceita conexões de gerenciamento via SSH na porta 22. Já o banco de dados RDS PostgreSQL (db.t3.micro) foi alocado estritamente dentro das sub-redes privadas, possuindo a propriedade publicly\_accessible = false. Essa decisão garante a segurança da infraestrutura, pois o banco de dados não possui IP público e aceita tráfego na porta 5432 vindo exclusivamente do Security Group da instância EC2.

# 

# Como o ambiente do AWS Academy Learner Lab possui restrições severas de permissão — como a proibição de criar ou modificar políticas e usuários IAM —, utilizei o perfil pré-existente LabInstanceProfile na EC2 via argumento iam\_instance\_profile, evitando qualquer recurso do tipo aws\_iam\_\*.

# 

# Além disso, lidei com as limitações inerentes ao laboratório, como a expiração contínua das credenciais temporárias (exigindo atualização do token no arquivo \~/.aws/credentials) e o bloqueio de políticas SCP para a leitura do Object Lock no S3, o que exigiu a criação prévia do bucket do remote state via AWS CLI.

# 

# Questão 4 - Validação e Responsabilidade

# Antes de rodar o terraform apply, fiz a validação do código com terraform validate e terraform plan, salvando a saída no arquivo evidencias/terraform-plan.txt. Em seguida, verifiquei o plano gerado aplicando um checklist rigoroso de segurança e conformidade:

# 

# Segurança IAM: Garanti que não existia nenhum recurso aws\_iam\_\* sendo criado.

# 

# Proteção do Banco: Confirmei que o RDS estava configurado com publicly\_accessible = false e storage\_encrypted = true.

# 

# Regras de Firewall: Verifiquei se a porta 5432 do banco aceitava tráfego exclusivamente vindo do Security Group da EC2 (com cidr\_blocks vazio).

# 

# Credenciais: Mantenho zero senhas gravadas no código, utilizando a variável de ambiente TF\_VAR\_db\_password marcada como sensitive.

# 

# Região e Parâmetros: Validei que todos os recursos e tags padrão apontavam para a região us-east-1.

# 

# Já vivi na prática o risco de aceitar código da IA sem revisar: o Dockerfile gerado tinha um erro (npm ci sem package-lock.json) que só descobri porque testei o build. Se eu tivesse aceitado sem testar, a entrega teria um contêiner que não sobe. Na infraestrutura o risco é maior, pois um erro pode expor o banco de dados na internet ou gastar os créditos do Lab.

# 

# Após a execução do apply, validei a infraestrutura na prática testando a API implantada na nuvem. Acessei o endpoint /health pelo IP público da EC2 (que retornou {"status":"ok"}) e executei os testes de CRUD (criando, buscando, atualizando e deletando dados no banco RDS). Além disso, conferi via AWS CLI que o bucket S3 do remote state permaneceu com versionamento, criptografia e bloqueio de acesso público ativos.

# 

# A evolução Git → Docker → Compose → Terraform me ensinou a testar em pequenos passos, a versionar cada mudança e a só avançar quando a etapa anterior funciona. Por isso, a IA funcionou como uma excelente assistente de produtividade, mas a validação e a responsabilidade final do projeto continuam sendo minhas.

