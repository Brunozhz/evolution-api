# Como Acessar o Login/Manager da Evolution API

## 📍 Link de Acesso

O Manager (interface web com login) está disponível em:

```
http://localhost:8080/manager
```

## 🔑 Credenciais de Login

### 1. Server URL
```
http://localhost:8080
```
(ou a URL onde sua API está rodando)

### 2. API Key
A API Key está configurada no arquivo `.env`. Para verificar:

```powershell
Get-Content .env | Select-String "AUTHENTICATION_API_KEY"
```

**API Key padrão:** `BQYHJGJHJ`

⚠️ **IMPORTANTE:** Por segurança, altere essa chave no arquivo `.env` antes de usar em produção!

## 📝 Passo a Passo para Fazer Login

1. **Acesse o Manager:**
   ```
   http://localhost:8080/manager
   ```

2. **Na tela de login, preencha:**
   - **Server URL:** `http://localhost:8080`
   - **API Key:** `BQYHJGJHJ` (ou a chave que você configurou)

3. **Clique em "Login"**

4. **Após o login bem-sucedido**, você terá acesso à interface completa do Manager onde pode:
   - Criar e gerenciar instâncias WhatsApp
   - Ver mensagens
   - Enviar mensagens
   - Gerenciar grupos
   - E muito mais!

## 🔒 Alterar a API Key

Para alterar a API Key (recomendado para segurança):

1. Abra o arquivo `.env`
2. Localize a linha:
   ```
   AUTHENTICATION_API_KEY=BQYHJGJHJ
   ```
3. Altere para uma chave segura:
   ```
   AUTHENTICATION_API_KEY=sua-chave-secreta-aqui
   ```
4. Reinicie a API

## 🌐 Outros Endpoints Úteis

- **Página inicial:** http://localhost:8080
- **Documentação Swagger:** http://localhost:8080/docs
- **Manager (Login):** http://localhost:8080/manager

## ⚠️ Se o Manager não aparecer

Se ao acessar `/manager` você ver um erro ou página não encontrada, verifique no arquivo `.env`:

```
SERVER_DISABLE_MANAGER=false
```

Se estiver como `true`, altere para `false` e reinicie a API.

## 🔍 Verificar se está funcionando

Acesse primeiro:
```
http://localhost:8080
```

Você deve ver uma resposta JSON com:
```json
{
    "status": 200,
    "message": "Welcome to the Evolution API, it is working!",
    "manager": "http://localhost:8080/manager"
}
```

Se o campo `manager` aparecer, significa que o Manager está habilitado!

