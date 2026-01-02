# 🔴 Solução Definitiva - Supabase no Railway

## Problema Identificado

```
✅ DATABASE_CONNECTION_URI is set
✅ Prisma consegue ler a connection string
❌ FATAL: Tenant or user not found
```

**Causa:** Connection Pooling (porta 6543) não funciona para migrations no Prisma. Você precisa usar **Direct Connection (porta 5432)**.

## ✅ Solução Imediata

### No Railway - Variables

**ATUALIZE** `DATABASE_CONNECTION_URI` para usar Direct Connection (porta **5432**):

```env
DATABASE_CONNECTION_URI=postgresql://postgres:9TRZd8ue$$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
```

### Mudanças Importantes:

1. ✅ **Host:** `db.yvyugaixtlctuwtnnlks.supabase.co` (não `aws-0-us-east-1.pooler.supabase.com`)
2. ✅ **Porta:** `5432` (não `6543`)
3. ✅ **Username:** `postgres` (não `postgres.yvyugaixtlctuwtnnlks`)
4. ✅ **Senha:** `9TRZd8ue$$acE9MC` (com `$$` - dois cifrões)

## 📋 Passo a Passo

### 1. No Railway → Variables

1. Encontre `DATABASE_CONNECTION_URI`
2. **DELETE** a variável atual
3. **+ New Variable**
4. Nome: `DATABASE_CONNECTION_URI`
5. Valor: 
   ```
   postgresql://postgres:9TRZd8ue$$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
   ```
6. **IMPORTANTE:** Use `$$` na senha (dois cifrões)!
7. Salve

### 2. Verificar Outras Variáveis

Certifique-se de que existem:

```env
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://postgres:9TRZd8ue$$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
AUTHENTICATION_API_KEY=9TRZd8ue$$acE9MC
SERVER_URL=https://evolution-api-production-2b06.up.railway.app
```

### 3. Reiniciar Deploy

1. Deployments → três pontos → **Redeploy**

## 🔍 Como Verificar se Funcionou

Após o deploy, nos logs você deve ver:

```
✅ [runWithProvider] DATABASE_CONNECTION_URI is set
✅ Datasource "db": PostgreSQL database "postgres" at "db.yvyugaixtlctuwtnnlks.supabase.co:5432"
✅ Migration succeeded
✅ Prisma generate succeeded
```

**NÃO deve mais aparecer:**
- ❌ `FATAL: Tenant or user not found`
- ❌ `Migration failed`

## 📝 Explicação Técnica

### Connection Pooling vs Direct Connection

| Tipo | Porta | Uso | Username |
|------|-------|-----|----------|
| **Connection Pooling** | 6543 | Aplicação (runtime) | `postgres.yvyugaixtlctuwtnnlks` |
| **Direct Connection** | 5432 | Migrations, Admin | `postgres` |

### Por que Connection Pooling Falha?

O PgBouncer (usado pelo Supabase para pooling) não suporta todas as operações que o Prisma Migrate precisa. Por isso, **migrations devem usar Direct Connection**.

### Formato das Connection Strings

**Connection Pooling (NÃO use para migrations):**
```
postgresql://postgres.yvyugaixtlctuwtnnlks:SENHA@aws-0-us-east-1.pooler.supabase.com:6543/postgres
```

**Direct Connection (USE para migrations):**
```
postgresql://postgres:SENHA@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
```

## ⚠️ Se Ainda Não Funcionar

### Verificar no Supabase

1. Acesse: https://supabase.com/dashboard/project/yvyugaixtlctuwtnnlks
2. Vá em **Settings** > **Database**
3. Verifique:
   - **Connection string** → **Direct connection**
   - Copie a connection string exata
   - Substitua `[YOUR-PASSWORD]` por `9TRZd8ue$$acE9MC` (com `$$`)

### Verificar Firewall

Se ainda der erro de conexão:

1. No Supabase → **Settings** > **Database**
2. Procure por **Network Restrictions**
3. Se houver whitelist de IPs:
   - Desabilite temporariamente OU
   - Adicione os IPs do Railway

### Testar Localmente

Para confirmar que a connection string funciona:

```powershell
$env:DATABASE_PROVIDER="postgresql"
$env:DATABASE_CONNECTION_URI="postgresql://postgres:9TRZd8ue`$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres"
npm run db:generate
```

Se funcionar localmente, deve funcionar no Railway.

## 🎯 Resumo da Solução

### O Que Mudou:
- ❌ **ANTES:** `aws-0-us-east-1.pooler.supabase.com:6543` (Connection Pooling)
- ✅ **DEPOIS:** `db.yvyugaixtlctuwtnnlks.supabase.co:5432` (Direct Connection)

### O Que Precisa Fazer:
1. Atualizar `DATABASE_CONNECTION_URI` no Railway
2. Usar Direct Connection (porta 5432)
3. Usar username `postgres` (não `postgres.yvyugaixtlctuwtnnlks`)
4. Manter `$$` na senha
5. Fazer redeploy

---

**Connection String Correta para Railway:**

```
DATABASE_CONNECTION_URI=postgresql://postgres:9TRZd8ue$$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
```

Copie exatamente isso e cole no Railway!

