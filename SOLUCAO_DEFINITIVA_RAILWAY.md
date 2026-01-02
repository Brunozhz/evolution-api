# 🔴 Solução Definitiva - Railway Crash

## Problema Identificado

Pelos logs:
```
Environment variables loaded from .env
Error: the URL must start with the protocol `postgresql://` or `postgres://`
```

**Causa:** O Prisma está tentando ler `DATABASE_CONNECTION_URI` do arquivo `.env`, mas no Railway não há arquivo `.env` - apenas variáveis de ambiente. O Prisma precisa que a variável esteja disponível como variável de ambiente quando executar.

## ✅ Correções Aplicadas

### 1. Scripts de Deploy Atualizados

Os scripts `deploy_database.sh` e `generate_database.sh` agora garantem que:
- `DATABASE_CONNECTION_URI` seja exportada como variável de ambiente
- `DATABASE_URL` seja exportada como variável de ambiente
- Ambas as variáveis estejam disponíveis para o Prisma

### 2. runWithProvider.js Atualizado

O script `runWithProvider.js` agora:
- Mapeia `DATABASE_CONNECTION_URI` para `DATABASE_URL` e vice-versa
- Garante que as variáveis estejam disponíveis quando o Prisma executar
- Passa as variáveis de ambiente corretamente para o comando do Prisma

## 📋 O Que Você Precisa Fazer no Railway

### 1. Configure Apenas `DATABASE_CONNECTION_URI`

No Railway → Variables, configure:

```env
DATABASE_CONNECTION_URI=postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$$acE9MC@aws-0-us-east-1.pooler.supabase.com:6543/postgres
```

**IMPORTANTE:** Use `$$` (dois cifrões) na senha, não `$`!

### 2. Variáveis Essenciais

Certifique-se de que estas variáveis existem:

```env
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$$acE9MC@aws-0-us-east-1.pooler.supabase.com:6543/postgres
AUTHENTICATION_API_KEY=9TRZd8ue$$acE9MC
SERVER_URL=https://evolution-api-production-2b06.up.railway.app
```

### 3. Faça o Deploy das Correções

As correções foram commitadas. Você precisa:

1. **Fazer pull das mudanças** (se ainda não fez):
   ```bash
   git pull origin main
   ```

2. **Ou fazer push novamente** (se já fez pull):
   - O Railway deve fazer deploy automaticamente
   - Ou vá em **Deployments** → **Redeploy**

## 🔍 Como Verificar se Funcionou

Após o deploy, nos logs você deve ver:

```
Database URL: postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$acE9MC@...
Migration succeeded
Prisma generate succeeded
```

**NÃO deve mais aparecer:**
- ❌ `Error: the URL must start with the protocol`
- ❌ `Migration failed`

## ⚠️ Se Ainda Não Funcionar

### Verificar se a Variável Está Configurada Corretamente

1. No Railway → **Variables**
2. Clique em `DATABASE_CONNECTION_URI`
3. Verifique se:
   - O valor está completo
   - Usa `$$` na senha (não `$`)
   - Não há espaços extras no início/fim
   - Não está entre aspas

### Testar com Direct Connection

Se Connection Pooling não funcionar, tente Direct Connection:

```env
DATABASE_CONNECTION_URI=postgresql://postgres:9TRZd8ue$$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
```

### Verificar Firewall do Supabase

1. Acesse: https://supabase.com/dashboard/project/yvyugaixtlctuwtnnlks
2. Vá em **Settings** > **Database**
3. Verifique se há restrições de rede
4. Desabilite temporariamente para testar

## 📝 Resumo das Mudanças

### Arquivos Modificados:
1. `Docker/scripts/deploy_database.sh` - Exporta `DATABASE_CONNECTION_URI`
2. `Docker/scripts/generate_database.sh` - Exporta `DATABASE_CONNECTION_URI`
3. `runWithProvider.js` - Mapeia variáveis e passa para o Prisma

### O Que Foi Corrigido:
- ✅ Prisma agora recebe `DATABASE_CONNECTION_URI` como variável de ambiente
- ✅ Mapeamento bidirecional entre `DATABASE_URL` e `DATABASE_CONNECTION_URI`
- ✅ Variáveis de ambiente passadas corretamente para o Prisma

## 🎯 Próximos Passos

1. Aguarde o deploy completar no Railway
2. Verifique os logs para confirmar que as migrations foram aplicadas
3. Teste a API: https://evolution-api-production-2b06.up.railway.app
4. Se funcionar, você verá a mensagem de boas-vindas!

