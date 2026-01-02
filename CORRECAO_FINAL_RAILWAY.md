# 🔴 Correção Final - Railway Crash

## Problema Crítico Identificado

Pelos logs:
```
Database URL: (vazio)
Error: the URL must start with the protocol `postgresql://` or `postgres://`
```

**O script de deploy estava procurando `DATABASE_URL` mas a variável configurada é `DATABASE_CONNECTION_URI`!**

## ✅ Solução Aplicada

**CORREÇÃO NO CÓDIGO:** Os scripts de deploy foram atualizados para mapear automaticamente `DATABASE_CONNECTION_URI` para `DATABASE_URL`.

Agora você só precisa configurar `DATABASE_CONNECTION_URI` no Railway!

### Variável para Configurar no Railway:

```env
DATABASE_CONNECTION_URI=postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$$acE9MC@aws-0-us-east-1.pooler.supabase.com:6543/postgres
```

**IMPORTANTE:** 
- Use `$$` (dois cifrões) na senha (não `$`)
- Configure apenas `DATABASE_CONNECTION_URI` (o script agora mapeia automaticamente)

## 📋 Passo a Passo Completo

### 1. No Railway - Variables:

Adicione/Atualize estas variáveis:

```env
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$$acE9MC@aws-0-us-east-1.pooler.supabase.com:6543/postgres
```

**Nota:** O script agora mapeia automaticamente `DATABASE_CONNECTION_URI` para `DATABASE_URL` internamente.

### 2. Verificar Todas as Variáveis Essenciais:

Certifique-se de que estas existem:

```env
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$$acE9MC@aws-0-us-east-1.pooler.supabase.com:6543/postgres
AUTHENTICATION_API_KEY=9TRZd8ue$$acE9MC
SERVER_URL=https://evolution-api-production-2b06.up.railway.app
```

### 3. Reiniciar o Deploy:

1. Vá em **Deployments**
2. Clique nos três pontos
3. Selecione **Redeploy**

## 🔍 Como Verificar se Está Correto

Após o redeploy, nos logs você deve ver:

```
Database URL: postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$acE9MC@...
```

Se aparecer a URL completa (não vazia), está funcionando!

## ⚠️ Se Ainda Não Funcionar

### Opção 1: Verificar se a variável foi salva

No Railway:
1. Vá em **Variables**
2. Clique em `DATABASE_URL`
3. Verifique se o valor está completo
4. Verifique se não há espaços extras

### Opção 2: Testar com Direct Connection

Se Connection Pooling não funcionar:

```env
DATABASE_URL=postgresql://postgres:9TRZd8ue$$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
DATABASE_CONNECTION_URI=postgresql://postgres:9TRZd8ue$$acE9MC@db.yvyugaixtlctuwtnnlks.supabase.co:5432/postgres
```

### Opção 3: Verificar Firewall do Supabase

1. Acesse: https://supabase.com/dashboard/project/yvyugaixtlctuwtnnlks
2. Vá em **Settings** > **Database**
3. Verifique se há restrições de rede
4. Desabilite temporariamente para testar

## 📝 Resumo das Variáveis Críticas

```env
# Essenciais para funcionar
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://postgres.yvyugaixtlctuwtnnlks:9TRZd8ue$$acE9MC@aws-0-us-east-1.pooler.supabase.com:6543/postgres
AUTHENTICATION_API_KEY=9TRZd8ue$$acE9MC
SERVER_URL=https://evolution-api-production-2b06.up.railway.app
```

**Lembre-se:** 
- Use `$$` na senha, não `$`!
- Configure apenas `DATABASE_CONNECTION_URI` (o script mapeia para `DATABASE_URL` automaticamente)

