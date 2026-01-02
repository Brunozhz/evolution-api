# Como Rodar a Evolution API Localmente

## Opção 1: Modo Desenvolvimento (Recomendado para testes)

Este modo tem hot reload (recarrega automaticamente quando você altera o código):

```powershell
npm run dev:server
```

**Vantagens:**
- Recarrega automaticamente quando você altera o código
- Melhor para desenvolvimento e testes
- Mostra logs detalhados

**Desvantagens:**
- Usa mais recursos
- Não é otimizado para produção

## Opção 2: Modo Produção

Este modo usa o código compilado (build):

```powershell
npm run start:prod
```

**Vantagens:**
- Otimizado para produção
- Usa menos recursos
- Mais rápido

**Desvantagens:**
- Precisa fazer build antes (`npm run build`)
- Não recarrega automaticamente

## Verificar se está funcionando

Após iniciar a API, abra seu navegador e acesse:

### 1. Página inicial:
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

### 2. Documentação Swagger:
```
http://localhost:8080/docs
```

Aqui você pode ver todos os endpoints disponíveis e testar a API.

## Comandos Úteis

### Parar a API
Pressione `Ctrl + C` no terminal onde a API está rodando.

### Ver logs
Os logs aparecem automaticamente no terminal quando você inicia a API.

### Verificar se a porta está em uso
Se a porta 8080 estiver ocupada, você pode alterar no arquivo `.env`:
```
SERVER_PORT=8081
```

## Troubleshooting

### Erro: "Port 8080 already in use"
- Altere a porta no arquivo `.env`: `SERVER_PORT=8081`
- Ou pare o processo que está usando a porta 8080

### Erro: "Cannot connect to database"
- Verifique se a connection string do Supabase está correta no `.env`
- Verifique se o Supabase está acessível

### Erro: "Prisma Client not generated"
Execute:
```powershell
$env:DATABASE_PROVIDER="postgresql"
npm run db:generate
```

## Próximos Passos

1. **Criar uma instância WhatsApp:**
   - Acesse a documentação: http://localhost:8080/docs
   - Use o endpoint `/instance/create` para criar uma nova instância

2. **Conectar WhatsApp:**
   - Use o endpoint `/instance/connect/{instance}` para conectar
   - Escaneie o QR Code que aparecer

3. **Enviar mensagens:**
   - Use o endpoint `/message/sendText/{instance}` para enviar mensagens

## Dicas

- Use a documentação Swagger (`/docs`) para explorar todos os endpoints
- Mantenha o terminal aberto para ver os logs
- Para produção, use PM2 (veja `INSTALACAO_WINDOWS.md`)

