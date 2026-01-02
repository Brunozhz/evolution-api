# Deploy da Evolution API no Vercel

## ⚠️ IMPORTANTE: Vercel não é ideal para Evolution API

A Evolution API **NÃO é compatível** com Vercel por várias razões:

### Problemas com Vercel:

1. **Serverless Functions têm timeout:**
   - Vercel tem limite de 10 segundos (Hobby) ou 60 segundos (Pro)
   - Evolution API precisa manter conexões WebSocket ativas
   - WhatsApp precisa de conexões persistentes

2. **Sem estado persistente:**
   - Instâncias WhatsApp precisam salvar estado
   - Arquivos de sessão precisam de armazenamento persistente
   - Vercel é stateless

3. **Conexões WebSocket:**
   - Evolution API usa WebSocket para comunicação em tempo real
   - Vercel tem suporte limitado a WebSocket

4. **Processos longos:**
   - WhatsApp precisa manter conexão ativa 24/7
   - Vercel é feito para requisições HTTP curtas

## ✅ Alternativas Recomendadas

### 1. **Railway** (Recomendado)
- ✅ Suporta Node.js completo
- ✅ Conexões persistentes
- ✅ WebSocket suportado
- ✅ Banco de dados incluído
- ✅ Fácil deploy

### 2. **Render**
- ✅ Suporta aplicações Node.js
- ✅ WebSocket suportado
- ✅ Deploy automático do GitHub

### 3. **DigitalOcean App Platform**
- ✅ Suporta Docker
- ✅ WebSocket suportado
- ✅ Escalável

### 4. **AWS EC2 / Lightsail**
- ✅ Controle total
- ✅ Sem limitações
- ✅ Mais complexo de configurar

### 5. **Heroku**
- ✅ Fácil deploy
- ✅ Suporta Node.js
- ⚠️ Pode ser caro

## 🚀 Como Fazer Deploy

### Opção 1: Railway (Mais Fácil)

1. Acesse: https://railway.app
2. Conecte seu repositório GitHub
3. Configure as variáveis de ambiente:
   - `DATABASE_PROVIDER=postgresql`
   - `DATABASE_CONNECTION_URI=sua-connection-string`
   - `AUTHENTICATION_API_KEY=sua-chave`
   - E outras variáveis do `.env`
4. Railway detecta automaticamente e faz o deploy

### Opção 2: Render

1. Acesse: https://render.com
2. Crie um novo "Web Service"
3. Conecte seu repositório
4. Configure:
   - **Build Command:** `npm install && npm run build`
   - **Start Command:** `npm run start:prod`
5. Adicione variáveis de ambiente

### Opção 3: DigitalOcean App Platform

1. Acesse: https://cloud.digitalocean.com
2. Crie um novo App
3. Conecte GitHub
4. Configure variáveis de ambiente
5. Deploy automático

## 📝 Variáveis de Ambiente para Deploy

Configure estas variáveis no seu provedor de deploy:

```env
# Servidor
SERVER_NAME=evolution
SERVER_TYPE=http
SERVER_PORT=8080
SERVER_URL=https://seu-dominio.com
SERVER_DISABLE_DOCS=false
SERVER_DISABLE_MANAGER=false

# Banco de Dados
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://postgres:senha@host:5432/postgres

# Autenticação
AUTHENTICATION_API_KEY=sua-chave-secreta-aqui

# Redis (opcional)
CACHE_REDIS_ENABLED=true
CACHE_REDIS_URI=redis://host:6379

# Outras configurações...
```

## 🔒 Segurança no Deploy

1. **NUNCA commite o arquivo `.env`**
   - Já está no `.gitignore`
   - Configure variáveis no painel do provedor

2. **Use variáveis de ambiente:**
   - Configure no painel do provedor
   - Não hardcode no código

3. **API Key segura:**
   - Use uma chave forte e única
   - Não compartilhe publicamente

## 📚 Próximos Passos

1. Escolha um provedor (Railway recomendado)
2. Configure variáveis de ambiente
3. Faça o deploy
4. Configure domínio personalizado
5. Teste a API

## ⚠️ Lembrete

Vercel é ótimo para sites estáticos e APIs serverless simples, mas **não é adequado** para Evolution API que precisa de:
- Conexões persistentes
- Processos longos
- Estado persistente
- WebSocket

Use Railway, Render ou DigitalOcean para melhor compatibilidade!

