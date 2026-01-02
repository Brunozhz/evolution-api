# Guia de Instalação - Evolution API (Windows)

Este guia adapta o processo de instalação da Evolution API para Windows, seguindo o passo a passo original.

## Pré-requisitos

- Windows 10/11 ou Windows Server
- Node.js v20.10.0 ou superior (recomendado usar NVM para Windows)
- Git para Windows
- PostgreSQL ou MySQL instalado e configurado
- Redis instalado e configurado (opcional, mas recomendado)

## 1. Instalação do Node.js com NVM para Windows

### Opção A: Usando NVM para Windows

1. Baixe o NVM para Windows: https://github.com/coreybutler/nvm-windows/releases
2. Instale o arquivo `nvm-setup.exe`
3. Abra um novo PowerShell ou CMD como Administrador
4. Instale o Node.js v20.10.0:

```powershell
nvm install 20.10.0
nvm use 20.10.0
```

5. Verifique a instalação:

```powershell
node --version
npm --version
```

### Opção B: Instalação Direta do Node.js

1. Baixe o Node.js v20.10.0: https://nodejs.org/
2. Execute o instalador
3. Verifique a instalação:

```powershell
node --version
npm --version
```

## 2. Clone do Repositório

Se ainda não clonou o repositório:

```powershell
cd C:\Users\SeuUsuario\Desktop\Github
git clone https://github.com/EvolutionAPI/evolution-api.git
cd evolution-api
```

## 3. Instalação de Dependências

```powershell
npm install
```

## 4. Configuração do Arquivo de Ambiente

O projeto usa arquivo `.env` (não YAML). Copie o arquivo de exemplo:

```powershell
Copy-Item env.example .env
```

Agora edite o arquivo `.env` com suas configurações:

```powershell
notepad .env
```

### Configurações Importantes no `.env`:

1. **Banco de Dados** - Configure a string de conexão:
   ```
   DATABASE_PROVIDER=postgresql
   DATABASE_CONNECTION_URI=postgresql://usuario:senha@localhost:5432/evolution_api
   ```

2. **Redis** (opcional mas recomendado):
   ```
   CACHE_REDIS_ENABLED=true
   CACHE_REDIS_URI=redis://localhost:6379
   ```

3. **API Key** - Altere para uma chave segura:
   ```
   AUTHENTICATION_API_KEY=sua-chave-secreta-aqui
   ```

4. **Servidor**:
   ```
   SERVER_PORT=8080
   SERVER_URL=http://localhost:8080
   ```

## 5. Configuração do Banco de Dados

### PostgreSQL

1. Certifique-se de que o PostgreSQL está instalado e rodando
2. Crie o banco de dados:

```sql
CREATE DATABASE evolution_api;
```

3. Configure a variável de ambiente:

```powershell
$env:DATABASE_PROVIDER="postgresql"
```

4. Gere o cliente Prisma:

```powershell
npm run db:generate
```

5. Execute as migrações:

```powershell
npm run db:deploy:win
```

### MySQL

1. Certifique-se de que o MySQL está instalado e rodando
2. Crie o banco de dados:

```sql
CREATE DATABASE evolution_api;
```

3. Configure a variável de ambiente:

```powershell
$env:DATABASE_PROVIDER="mysql"
```

4. Gere o cliente Prisma:

```powershell
npm run db:generate
```

5. Execute as migrações:

```powershell
npm run db:deploy:win
```

## 6. Build do Projeto

```powershell
npm run build
```

## 7. Iniciar a API

### Modo Desenvolvimento (com hot reload):

```powershell
npm run dev:server
```

### Modo Produção:

```powershell
npm run start:prod
```

## 8. Verificar se a API está Funcionando

Abra seu navegador e acesse:

```
http://localhost:8080
```

Você deve ver uma resposta JSON:

```json
{
    "status": 200,
    "message": "Bem-vindo à Evolution API, ela está funcionando!",
    "version": "2.3.7",
    "documentation": "http://localhost:8080/docs"
}
```

A documentação Swagger estará disponível em:

```
http://localhost:8080/docs
```

## 9. Instalação e Configuração do PM2 (Opcional)

PM2 é um gerenciador de processos para manter a API rodando em produção.

### Instalação do PM2:

```powershell
npm install pm2 -g
```

### Iniciar a API com PM2:

```powershell
pm2 start "npm run start:prod" --name ApiEvolution
```

### Configurar PM2 para iniciar automaticamente:

```powershell
pm2 startup
pm2 save
```

### Comandos Úteis do PM2:

```powershell
pm2 list              # Listar processos
pm2 logs ApiEvolution  # Ver logs
pm2 restart ApiEvolution  # Reiniciar
pm2 stop ApiEvolution     # Parar
pm2 delete ApiEvolution   # Remover
```

### PM2 com Mais Memória (se necessário):

```powershell
pm2 start "npm run start:prod" --name ApiEvolution --node-args="--max-old-space-size=4096" --max-memory-restart 4G
```

## 10. Configuração do Nginx (Opcional - para Produção)

### Instalação do Nginx no Windows

1. Baixe o Nginx: http://nginx.org/en/download.html
2. Extraia para `C:\nginx`
3. Edite `C:\nginx\conf\nginx.conf`

### Configuração do Nginx para Evolution API

Crie um arquivo `C:\nginx\conf\conf.d\api.conf`:

```nginx
server {
    listen 80;
    server_name seu-dominio.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### Iniciar o Nginx:

```powershell
cd C:\nginx
.\nginx.exe
```

### Recarregar Configuração:

```powershell
.\nginx.exe -s reload
```

## 11. Certificado SSL com Certbot (Opcional)

Para Windows, você pode usar:

1. **Certbot para Windows**: https://certbot.eff.org/
2. Ou usar serviços como **Cloudflare** para SSL gratuito
3. Ou usar **Let's Encrypt** via WSL (Windows Subsystem for Linux)

## Troubleshooting

### Erro: "Cannot find module"

```powershell
npm install
```

### Erro: "Database connection failed"

- Verifique se o banco de dados está rodando
- Verifique as credenciais no arquivo `.env`
- Verifique se a variável `DATABASE_PROVIDER` está configurada corretamente

### Erro: "Port 8080 already in use"

Altere a porta no arquivo `.env`:

```
SERVER_PORT=8081
```

### Erro: "Prisma Client not generated"

```powershell
npm run db:generate
```

## Próximos Passos

1. Configure suas integrações (Chatwoot, Typebot, OpenAI, etc.) no arquivo `.env`
2. Configure webhooks se necessário
3. Configure o Redis para melhor performance
4. Configure SSL/HTTPS para produção
5. Configure backups do banco de dados

## Documentação Adicional

- Documentação da API: http://localhost:8080/docs
- Repositório: https://github.com/EvolutionAPI/evolution-api
- Suporte: Verifique as issues no GitHub

