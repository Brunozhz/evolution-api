# Script de Instalação - Evolution API (Windows)
# Execute este script no PowerShell como Administrador

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Evolution API - Instalação para Windows" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se está no diretório correto
if (-not (Test-Path "package.json")) {
    Write-Host "ERRO: Execute este script no diretório raiz do projeto evolution-api" -ForegroundColor Red
    exit 1
}

# Verificar Node.js
Write-Host "Verificando Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version
    Write-Host "Node.js encontrado: $nodeVersion" -ForegroundColor Green
    
    # Verificar se é versão 20.x
    if ($nodeVersion -notmatch "^v20\.") {
        Write-Host "AVISO: Recomendado Node.js v20.x. Versão atual: $nodeVersion" -ForegroundColor Yellow
    }
} catch {
    Write-Host "ERRO: Node.js não encontrado. Instale Node.js v20.10.0 ou superior." -ForegroundColor Red
    Write-Host "Download: https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}

# Verificar npm
Write-Host "Verificando npm..." -ForegroundColor Yellow
try {
    $npmVersion = npm --version
    Write-Host "npm encontrado: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "ERRO: npm não encontrado." -ForegroundColor Red
    exit 1
}

# Criar arquivo .env se não existir
Write-Host ""
Write-Host "Verificando arquivo .env..." -ForegroundColor Yellow
if (-not (Test-Path ".env")) {
    if (Test-Path "env.example") {
        Copy-Item "env.example" ".env"
        Write-Host "Arquivo .env criado a partir de env.example" -ForegroundColor Green
        Write-Host "IMPORTANTE: Edite o arquivo .env com suas configurações antes de continuar!" -ForegroundColor Yellow
        Write-Host "Pressione qualquer tecla para abrir o arquivo .env no Notepad..." -ForegroundColor Cyan
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        notepad .env
    } else {
        Write-Host "ERRO: Arquivo env.example não encontrado." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Arquivo .env já existe." -ForegroundColor Green
}

# Instalar dependências
Write-Host ""
Write-Host "Instalando dependências do npm..." -ForegroundColor Yellow
Write-Host "Isso pode levar alguns minutos..." -ForegroundColor Cyan
npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERRO: Falha ao instalar dependências." -ForegroundColor Red
    exit 1
}

Write-Host "Dependências instaladas com sucesso!" -ForegroundColor Green

# Verificar se precisa configurar o banco de dados
Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Próximos Passos:" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Configure o arquivo .env com suas credenciais:" -ForegroundColor Yellow
Write-Host "   - DATABASE_CONNECTION_URI" -ForegroundColor White
Write-Host "   - CACHE_REDIS_URI (se usar Redis)" -ForegroundColor White
Write-Host "   - AUTHENTICATION_API_KEY (altere para uma chave segura)" -ForegroundColor White
Write-Host ""
Write-Host "2. Configure a variável de ambiente DATABASE_PROVIDER:" -ForegroundColor Yellow
Write-Host "   PowerShell: `$env:DATABASE_PROVIDER='postgresql'" -ForegroundColor White
Write-Host "   ou" -ForegroundColor White
Write-Host "   PowerShell: `$env:DATABASE_PROVIDER='mysql'" -ForegroundColor White
Write-Host ""
Write-Host "3. Gere o cliente Prisma:" -ForegroundColor Yellow
Write-Host "   npm run db:generate" -ForegroundColor White
Write-Host ""
Write-Host "4. Execute as migrações do banco de dados:" -ForegroundColor Yellow
Write-Host "   npm run db:deploy:win" -ForegroundColor White
Write-Host ""
Write-Host "5. Faça o build do projeto:" -ForegroundColor Yellow
Write-Host "   npm run build" -ForegroundColor White
Write-Host ""
Write-Host "6. Inicie a API:" -ForegroundColor Yellow
Write-Host "   Desenvolvimento: npm run dev:server" -ForegroundColor White
Write-Host "   Produção: npm run start:prod" -ForegroundColor White
Write-Host ""
Write-Host "7. Acesse a API em: http://localhost:8080" -ForegroundColor Green
Write-Host "   Documentação: http://localhost:8080/docs" -ForegroundColor Green
Write-Host ""

# Perguntar se deseja fazer o build agora
$build = Read-Host "Deseja fazer o build do projeto agora? (S/N)"
if ($build -eq "S" -or $build -eq "s") {
    Write-Host ""
    Write-Host "Fazendo build do projeto..." -ForegroundColor Yellow
    npm run build
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Build concluído com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "ERRO: Falha no build. Verifique os erros acima." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Instalação concluída!" -ForegroundColor Green
Write-Host "Consulte o arquivo INSTALACAO_WINDOWS.md para mais detalhes." -ForegroundColor Cyan

