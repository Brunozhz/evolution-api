# Script para Configurar Supabase na Evolution API
# Execute este script e forneça a connection string do Supabase

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Configuração do Supabase - Evolution API" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Para encontrar a connection string do Supabase:" -ForegroundColor Yellow
Write-Host "1. Acesse: https://supabase.com/dashboard" -ForegroundColor White
Write-Host "2. Selecione seu projeto" -ForegroundColor White
Write-Host "3. Vá em Settings > Database" -ForegroundColor White
Write-Host "4. Em 'Connection string', copie a string que começa com 'postgresql://...'" -ForegroundColor White
Write-Host "   (Use a opção 'Connection pooling' ou 'Direct connection')" -ForegroundColor White
Write-Host ""

$connectionString = Read-Host "Cole a connection string do PostgreSQL aqui"

if ([string]::IsNullOrWhiteSpace($connectionString)) {
    Write-Host "ERRO: Connection string não fornecida!" -ForegroundColor Red
    exit 1
}

# Validar formato
if ($connectionString -notmatch "^postgresql://") {
    Write-Host "AVISO: A connection string deve começar com 'postgresql://'" -ForegroundColor Yellow
    $confirm = Read-Host "Deseja continuar mesmo assim? (S/N)"
    if ($confirm -ne "S" -and $confirm -ne "s") {
        exit 1
    }
}

# Ler o arquivo .env
if (-not (Test-Path ".env")) {
    Write-Host "ERRO: Arquivo .env não encontrado!" -ForegroundColor Red
    exit 1
}

$envContent = Get-Content .env -Raw

# Substituir a connection string
if ($envContent -match "DATABASE_CONNECTION_URI=.*") {
    $envContent = $envContent -replace "DATABASE_CONNECTION_URI=.*", "DATABASE_CONNECTION_URI=$connectionString"
    Write-Host "Connection string atualizada!" -ForegroundColor Green
} else {
    # Adicionar se não existir
    $envContent += "`nDATABASE_CONNECTION_URI=$connectionString`n"
    Write-Host "Connection string adicionada!" -ForegroundColor Green
}

# Garantir que DATABASE_PROVIDER está configurado como postgresql
if ($envContent -match "DATABASE_PROVIDER=.*") {
    $envContent = $envContent -replace "DATABASE_PROVIDER=.*", "DATABASE_PROVIDER=postgresql"
} else {
    $envContent += "`nDATABASE_PROVIDER=postgresql`n"
}

# Salvar o arquivo
Set-Content .env -Value $envContent

Write-Host ""
Write-Host "Configuração concluída!" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos passos:" -ForegroundColor Yellow
Write-Host "1. Execute: `$env:DATABASE_PROVIDER='postgresql'" -ForegroundColor White
Write-Host "2. Execute: npm run db:generate" -ForegroundColor White
Write-Host "3. Execute: npm run db:deploy:win" -ForegroundColor White
Write-Host ""

