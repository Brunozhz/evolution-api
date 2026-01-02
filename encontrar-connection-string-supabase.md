# Como Encontrar a Connection String no Supabase

## Método 1: Settings > Database

1. Acesse: https://supabase.com/dashboard/project/yvyugaixtlctuwtnnlks
2. No menu lateral esquerdo, clique em **Settings** (ícone de engrenagem)
3. Clique em **Database**
4. Role a página até encontrar a seção **Connection string** ou **Connection info**
5. Você verá algo como:
   - **Connection pooling** (URI)
   - **Direct connection** (URI)
   - Ou apenas **Connection string**

## Método 2: Construir Manualmente

Se não encontrar a connection string pronta, você pode construí-la manualmente:

### Informações que você precisa:

1. **Host**: Geralmente é `aws-0-[região].pooler.supabase.com` ou `db.[projeto].supabase.co`
2. **Porta**: 
   - 6543 para Connection Pooling (recomendado)
   - 5432 para Direct Connection
3. **Database**: Geralmente é `postgres`
4. **User**: Geralmente é `postgres.[projeto]` ou apenas `postgres`
5. **Password**: A senha do banco de dados PostgreSQL

### Onde encontrar a senha:

1. Vá em **Settings** > **Database**
2. Procure por **Database password** ou **Reset database password**
3. Se você não definiu uma senha, pode precisar resetá-la

### Formato da Connection String:

```
postgresql://[USER]:[PASSWORD]@[HOST]:[PORT]/[DATABASE]
```

Exemplo:
```
postgresql://postgres.yvyugaixtlctuwtnnlks:SUA_SENHA_AQUI@aws-0-us-east-1.pooler.supabase.com:6543/postgres
```

## Método 3: Via API ou SQL Editor

1. Vá em **SQL Editor** no menu lateral
2. Execute uma query simples para testar a conexão
3. As informações de conexão podem aparecer nos logs

## Método 4: Verificar Connection Info

1. **Settings** > **Database**
2. Procure por seções como:
   - **Connection info**
   - **Database settings**
   - **Connection parameters**
   - **Connection pooling**

## Se ainda não encontrar:

1. Verifique se você tem permissões de administrador no projeto
2. Tente resetar a senha do banco em **Settings** > **Database** > **Reset database password**
3. A interface do Supabase pode ter mudado - tente procurar por "connection", "database", "postgres" na barra de busca do painel

## Informações do seu projeto:

- **Project URL**: yvyugaixtlctuwtnnlks.supabase.co
- **Project Reference**: yvyugaixtlctuwtnnlks

Com essas informações, podemos tentar construir a connection string se você tiver a senha do banco.

