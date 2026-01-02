# Configuração do Supabase - Evolution API

## Passo 1: Obter a Connection String do Supabase

1. Acesse o painel do Supabase: https://supabase.com/dashboard
2. Selecione seu projeto (yvyugaixtlctuwtnnlks)
3. Vá em **Settings** > **Database**
4. Role até a seção **Connection string**
5. Você verá duas opções:
   - **Connection pooling** (recomendado para produção) - porta 6543
   - **Direct connection** (para migrações) - porta 5432

### Formato da Connection String:

**Connection Pooling (recomendado):**
```
postgresql://postgres.yvyugaixtlctuwtnnlks:[SENHA]@aws-0-us-east-1.pooler.supabase.com:6543/postgres
```

**Direct Connection (para migrações):**
```
postgresql://postgres.yvyugaixtlctuwtnnlks:[SENHA]@aws-0-us-east-1.pooler.supabase.com:5432/postgres
```

**Importante:** Substitua `[SENHA]` pela senha do seu banco de dados PostgreSQL do Supabase.

## Passo 2: Configurar no Evolution API

### Opção A: Usar o Script Automático

Execute o script PowerShell:

```powershell
.\configurar-supabase.ps1
```

O script irá:
- Pedir a connection string
- Atualizar o arquivo `.env` automaticamente
- Configurar o `DATABASE_PROVIDER` como `postgresql`

### Opção B: Configuração Manual

1. Abra o arquivo `.env` no editor de texto
2. Localize a linha:
   ```
   DATABASE_CONNECTION_URI=postgresql://username:password@localhost:5432/evolution_api
   ```
3. Substitua pela connection string do Supabase:
   ```
   DATABASE_CONNECTION_URI=postgresql://postgres.yvyugaixtlctuwtnnlks:[SENHA]@aws-0-us-east-1.pooler.supabase.com:6543/postgres
   ```
4. Certifique-se de que está configurado:
   ```
   DATABASE_PROVIDER=postgresql
   ```

## Passo 3: Executar Migrações

Após configurar a connection string:

```powershell
# Configurar variável de ambiente
$env:DATABASE_PROVIDER="postgresql"

# Gerar cliente Prisma
npm run db:generate

# Executar migrações
npm run db:deploy:win
```

## Passo 4: Verificar Conexão

Após executar as migrações, você pode testar a conexão iniciando a API:

```powershell
npm run start:prod
```

Se tudo estiver configurado corretamente, a API iniciará sem erros de conexão com o banco.

## Troubleshooting

### Erro: "Can't reach database server"

- Verifique se a connection string está correta
- Certifique-se de que a senha está correta
- Verifique se está usando a porta correta (6543 para pooling, 5432 para direct)

### Erro: "Authentication failed"

- Verifique se a senha do banco está correta
- A senha pode ser encontrada em Settings > Database > Database password

### Erro: "Database does not exist"

- O Supabase já cria o banco `postgres` por padrão
- Não é necessário criar um banco separado
- Use `postgres` como nome do banco na connection string

## Notas Importantes

1. **Connection Pooling vs Direct Connection:**
   - Use **Connection Pooling** (porta 6543) para a aplicação em produção
   - Use **Direct Connection** (porta 5432) apenas para migrações

2. **Segurança:**
   - Nunca commite o arquivo `.env` no Git
   - Mantenha suas credenciais seguras
   - Use variáveis de ambiente em produção

3. **Limites do Supabase:**
   - Verifique os limites de conexão do seu plano
   - Connection pooling ajuda a gerenciar conexões eficientemente

