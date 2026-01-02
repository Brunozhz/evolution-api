# Variáveis de Ambiente para Deploy (Railway, Render, etc.)

## 📋 Lista Completa de Variáveis de Ambiente

Configure todas essas variáveis no painel do seu provedor de deploy (Railway, Render, DigitalOcean, etc.)

---

## 🔴 OBRIGATÓRIAS (Essenciais para funcionar)

### Servidor
```env
SERVER_NAME=evolution
SERVER_TYPE=http
SERVER_PORT=8080
SERVER_URL=https://seu-dominio.com
SERVER_DISABLE_DOCS=false
SERVER_DISABLE_MANAGER=false
```

### Banco de Dados
```env
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://postgres:senha@host:5432/postgres
DATABASE_CONNECTION_CLIENT_NAME=evolution
```

### Autenticação
```env
AUTHENTICATION_API_KEY=9TRZd8ue$acE9MC
AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES=false
```

---

## 🟡 IMPORTANTES (Recomendadas)

### Cache
```env
# Redis (se tiver)
CACHE_REDIS_ENABLED=true
CACHE_REDIS_URI=redis://host:6379
CACHE_REDIS_PREFIX_KEY=evolution-cache
CACHE_REDIS_TTL=604800
CACHE_REDIS_SAVE_INSTANCES=true

# Cache Local (fallback se não tiver Redis)
CACHE_LOCAL_ENABLED=true
CACHE_LOCAL_TTL=86400
```

### Banco de Dados - Configurações de Salvamento
```env
DATABASE_SAVE_DATA_INSTANCE=true
DATABASE_SAVE_DATA_NEW_MESSAGE=true
DATABASE_SAVE_MESSAGE_UPDATE=true
DATABASE_SAVE_DATA_CONTACTS=true
DATABASE_SAVE_DATA_CHATS=true
DATABASE_SAVE_DATA_HISTORIC=true
DATABASE_SAVE_DATA_LABELS=true
DATABASE_SAVE_IS_ON_WHATSAPP=true
DATABASE_SAVE_IS_ON_WHATSAPP_DAYS=7
DATABASE_DELETE_MESSAGE=false
```

### CORS
```env
CORS_ORIGIN=*
CORS_METHODS=POST,GET,PUT,DELETE
CORS_CREDENTIALS=true
```

### Logs
```env
LOG_LEVEL=ERROR,WARN,DEBUG,INFO,LOG,VERBOSE,DARK,WEBHOOKS,WEBSOCKET
LOG_COLOR=true
LOG_BAILEYS=error
```

### Idioma
```env
LANGUAGE=pt-BR
```

### Instâncias
```env
DEL_INSTANCE=false
DEL_TEMP_INSTANCES=true
```

---

## 🟢 OPCIONAIS (Configurar conforme necessário)

### SSL (se usar HTTPS direto)
```env
SSL_CONF_PRIVKEY=
SSL_CONF_FULLCHAIN=
```

### WebSocket
```env
WEBSOCKET_ENABLED=true
WEBSOCKET_GLOBAL_EVENTS=true
WEBSOCKET_ALLOWED_HOSTS=
```

### Webhook Global
```env
WEBHOOK_GLOBAL_URL=
WEBHOOK_GLOBAL_ENABLED=false
WEBHOOK_GLOBAL_WEBHOOK_BY_EVENTS=false
```

### WhatsApp Business
```env
WA_BUSINESS_TOKEN_WEBHOOK=evolution
WA_BUSINESS_URL=https://graph.facebook.com
WA_BUSINESS_VERSION=v18.0
WA_BUSINESS_LANGUAGE=en
```

### Configurações de Sessão
```env
CONFIG_SESSION_PHONE_CLIENT=Evolution API
CONFIG_SESSION_PHONE_NAME=Chrome
```

### QR Code
```env
QRCODE_LIMIT=30
QRCODE_COLOR=#198754
```

### RabbitMQ (se usar)
```env
RABBITMQ_ENABLED=false
RABBITMQ_GLOBAL_ENABLED=false
RABBITMQ_PREFIX_KEY=
RABBITMQ_EXCHANGE_NAME=evolution_exchange
RABBITMQ_URI=
RABBITMQ_FRAME_MAX=8192
```

### NATS (se usar)
```env
NATS_ENABLED=false
NATS_GLOBAL_ENABLED=false
NATS_PREFIX_KEY=
NATS_EXCHANGE_NAME=evolution_exchange
NATS_URI=
```

### SQS (se usar)
```env
SQS_ENABLED=false
SQS_GLOBAL_ENABLED=false
SQS_GLOBAL_FORCE_SINGLE_QUEUE=false
SQS_GLOBAL_PREFIX_NAME=global
SQS_ACCESS_KEY_ID=
SQS_SECRET_ACCESS_KEY=
SQS_ACCOUNT_ID=
SQS_REGION=
SQS_MAX_PAYLOAD_SIZE=1048576
```

### Kafka (se usar)
```env
KAFKA_ENABLED=false
KAFKA_CLIENT_ID=evolution-api
KAFKA_BROKERS=localhost:9092
KAFKA_CONNECTION_TIMEOUT=3000
KAFKA_REQUEST_TIMEOUT=30000
KAFKA_GLOBAL_ENABLED=false
KAFKA_CONSUMER_GROUP_ID=evolution-api-consumers
KAFKA_TOPIC_PREFIX=evolution
KAFKA_NUM_PARTITIONS=1
KAFKA_REPLICATION_FACTOR=1
KAFKA_AUTO_CREATE_TOPICS=true
```

### Pusher (se usar)
```env
PUSHER_ENABLED=false
PUSHER_GLOBAL_ENABLED=false
PUSHER_GLOBAL_APP_ID=
PUSHER_GLOBAL_KEY=
PUSHER_GLOBAL_SECRET=
PUSHER_GLOBAL_CLUSTER=
PUSHER_GLOBAL_USE_TLS=false
```

### Integrações - Typebot
```env
TYPEBOT_ENABLED=false
TYPEBOT_API_VERSION=old
TYPEBOT_SEND_MEDIA_BASE64=false
```

### Integrações - Chatwoot
```env
CHATWOOT_ENABLED=false
CHATWOOT_MESSAGE_DELETE=false
CHATWOOT_MESSAGE_READ=false
CHATWOOT_BOT_CONTACT=true
CHATWOOT_IMPORT_DATABASE_CONNECTION_URI=
CHATWOOT_IMPORT_PLACEHOLDER_MEDIA_MESSAGE=false
```

### Integrações - OpenAI
```env
OPENAI_ENABLED=false
OPENAI_API_KEY_GLOBAL=
```

### Integrações - Dify
```env
DIFY_ENABLED=false
```

### Integrações - N8N
```env
N8N_ENABLED=false
```

### Integrações - EvoAI
```env
EVOAI_ENABLED=false
```

### Integrações - Flowise
```env
FLOWISE_ENABLED=false
```

### S3 / MinIO (se usar)
```env
S3_ENABLED=false
S3_ACCESS_KEY=
S3_SECRET_KEY=
S3_ENDPOINT=
S3_BUCKET=
S3_PORT=9000
S3_USE_SSL=false
S3_REGION=
S3_SKIP_POLICY=false
S3_SAVE_VIDEO=false
```

### Métricas Prometheus
```env
PROMETHEUS_METRICS=false
METRICS_AUTH_REQUIRED=false
METRICS_USER=
METRICS_PASSWORD=
METRICS_ALLOWED_IPS=
```

### Telemetria
```env
TELEMETRY_ENABLED=true
TELEMETRY_URL=
```

### Proxy
```env
PROXY_HOST=
PROXY_PORT=
PROXY_PROTOCOL=
PROXY_USERNAME=
PROXY_PASSWORD=
```

### Conversor de Áudio
```env
API_AUDIO_CONVERTER=
API_AUDIO_CONVERTER_KEY=
```

### Facebook
```env
FACEBOOK_APP_ID=
FACEBOOK_CONFIG_ID=
FACEBOOK_USER_TOKEN=
```

### Sentry
```env
SENTRY_DSN=
```

### Event Emitter
```env
EVENT_EMITTER_MAX_LISTENERS=50
```

### Provider
```env
PROVIDER_ENABLED=false
PROVIDER_HOST=
PROVIDER_PORT=5656
PROVIDER_PREFIX=evolution
```

### Webhook - Eventos (todos false por padrão)
```env
WEBHOOK_EVENTS_APPLICATION_STARTUP=false
WEBHOOK_EVENTS_INSTANCE_CREATE=false
WEBHOOK_EVENTS_INSTANCE_DELETE=false
WEBHOOK_EVENTS_QRCODE_UPDATED=false
WEBHOOK_EVENTS_MESSAGES_SET=false
WEBHOOK_EVENTS_MESSAGES_UPSERT=false
WEBHOOK_EVENTS_MESSAGES_EDITED=false
WEBHOOK_EVENTS_MESSAGES_UPDATE=false
WEBHOOK_EVENTS_MESSAGES_DELETE=false
WEBHOOK_EVENTS_SEND_MESSAGE=false
WEBHOOK_EVENTS_SEND_MESSAGE_UPDATE=false
WEBHOOK_EVENTS_CONTACTS_SET=false
WEBHOOK_EVENTS_CONTACTS_UPDATE=false
WEBHOOK_EVENTS_CONTACTS_UPSERT=false
WEBHOOK_EVENTS_PRESENCE_UPDATE=false
WEBHOOK_EVENTS_CHATS_SET=false
WEBHOOK_EVENTS_CHATS_UPDATE=false
WEBHOOK_EVENTS_CHATS_UPSERT=false
WEBHOOK_EVENTS_CHATS_DELETE=false
WEBHOOK_EVENTS_CONNECTION_UPDATE=false
WEBHOOK_EVENTS_LABELS_EDIT=false
WEBHOOK_EVENTS_LABELS_ASSOCIATION=false
WEBHOOK_EVENTS_GROUPS_UPSERT=false
WEBHOOK_EVENTS_GROUPS_UPDATE=false
WEBHOOK_EVENTS_GROUP_PARTICIPANTS_UPDATE=false
WEBHOOK_EVENTS_CALL=false
WEBHOOK_EVENTS_TYPEBOT_START=false
WEBHOOK_EVENTS_TYPEBOT_CHANGE_STATUS=false
WEBHOOK_EVENTS_ERRORS=false
WEBHOOK_EVENTS_ERRORS_WEBHOOK=
```

### Webhook - Configurações
```env
WEBHOOK_REQUEST_TIMEOUT_MS=30000
WEBHOOK_RETRY_MAX_ATTEMPTS=10
WEBHOOK_RETRY_INITIAL_DELAY_SECONDS=5
WEBHOOK_RETRY_USE_EXPONENTIAL_BACKOFF=true
WEBHOOK_RETRY_MAX_DELAY_SECONDS=300
WEBHOOK_RETRY_JITTER_FACTOR=0.2
WEBHOOK_RETRY_NON_RETRYABLE_STATUS_CODES=400,401,403,404,422
```

---

## 📝 Configuração Mínima para Deploy

Para começar, você precisa apenas destas variáveis:

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
DATABASE_CONNECTION_CLIENT_NAME=evolution

# Autenticação
AUTHENTICATION_API_KEY=9TRZd8ue$acE9MC
AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES=false

# Cache Local (sem Redis)
CACHE_LOCAL_ENABLED=true
CACHE_LOCAL_TTL=86400
CACHE_REDIS_ENABLED=false

# Idioma
LANGUAGE=pt-BR

# Logs
LOG_LEVEL=ERROR,WARN,DEBUG,INFO,LOG,VERBOSE,DARK,WEBHOOKS,WEBSOCKET
LOG_COLOR=true
LOG_BAILEYS=error

# CORS
CORS_ORIGIN=*
CORS_METHODS=POST,GET,PUT,DELETE
CORS_CREDENTIALS=true

# WebSocket
WEBSOCKET_ENABLED=true
WEBSOCKET_GLOBAL_EVENTS=true

# Instâncias
DEL_INSTANCE=false
DEL_TEMP_INSTANCES=true

# Banco - Salvamento
DATABASE_SAVE_DATA_INSTANCE=true
DATABASE_SAVE_DATA_NEW_MESSAGE=true
DATABASE_SAVE_MESSAGE_UPDATE=true
DATABASE_SAVE_DATA_CONTACTS=true
DATABASE_SAVE_DATA_CHATS=true
DATABASE_SAVE_DATA_HISTORIC=true
DATABASE_SAVE_DATA_LABELS=true
DATABASE_SAVE_IS_ON_WHATSAPP=true
DATABASE_SAVE_IS_ON_WHATSAPP_DAYS=7
DATABASE_DELETE_MESSAGE=false
```

---

## 🚀 Como Configurar no Railway

1. Acesse seu projeto no Railway
2. Vá em **Variables**
3. Clique em **+ New Variable**
4. Adicione cada variável uma por uma
5. Ou use **Raw Editor** para colar todas de uma vez

## 🚀 Como Configurar no Render

1. Acesse seu serviço no Render
2. Vá em **Environment**
3. Clique em **Add Environment Variable**
4. Adicione cada variável

## ⚠️ IMPORTANTE

- **NUNCA** commite o arquivo `.env`
- Use variáveis de ambiente no painel do provedor
- Valores sensíveis (senhas, API keys) devem ser secretos
- Para produção, use valores diferentes dos de desenvolvimento

## 🔐 Valores que você DEVE alterar

1. `AUTHENTICATION_API_KEY` - Use uma chave forte e única
2. `DATABASE_CONNECTION_URI` - Sua connection string do Supabase
3. `SERVER_URL` - Seu domínio de produção
4. `CACHE_REDIS_URI` - Se usar Redis (opcional)

---

## 📋 Checklist de Deploy

- [ ] Configurar variáveis obrigatórias
- [ ] Configurar `SERVER_URL` com seu domínio
- [ ] Configurar `DATABASE_CONNECTION_URI` com Supabase
- [ ] Configurar `AUTHENTICATION_API_KEY` com chave segura
- [ ] Configurar variáveis de cache (local ou Redis)
- [ ] Configurar CORS se necessário
- [ ] Configurar integrações se usar (Typebot, Chatwoot, etc.)
- [ ] Testar API após deploy
- [ ] Verificar logs para erros

