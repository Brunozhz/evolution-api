# Script para Construir Connection String do Supabase
# Baseado nas informações do seu projeto

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Construir Connection String - Supabase" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

$projectRef = "yvyugaixtlctuwtnnlks"

Write-Host "Informações do seu projeto:" -ForegroundColor Yellow
Write-Host "Project Reference: $projectRef" -ForegroundColor White
Write-Host ""

Write-Host "Vamos construir a connection string manualmente." -ForegroundColor Yellow
Write-Host ""

# Perguntar pela senha do banco
Write-Host "IMPORTANTE: Você precisa da senha do banco de dados PostgreSQL." -ForegroundColor Yellow
Write-Host "Se não souber, você pode:" -ForegroundColor White
Write-Host "1. Ir em Settings > Database > Reset database password" -ForegroundColor White
Write-Host "2. Ou verificar se você definiu uma senha ao criar o projeto" -ForegroundColor White
Write-Host ""

$password = Read-Host "Digite a senha do banco de dados PostgreSQL" -AsSecureString
$passwordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

if ([string]::IsNullOrWhiteSpace($passwordPlain)) {
    Write-Host "ERRO: Senha não fornecida!" -ForegroundColor Red
    exit 1
}

# Perguntar qual tipo de conexão
Write-Host ""
Write-Host "Escolha o tipo de conexão:" -ForegroundColor Yellow
Write-Host "1. Connection Pooling (porta 6543) - RECOMENDADO para produção" -ForegroundColor White
Write-Host "2. Direct Connection (porta 5432) - Para migrações" -ForegroundColor White
Write-Host ""
$tipo = Read-Host "Digite 1 ou 2 (padrão: 1)"

if ($tipo -eq "2") {
    $porta = "5432"
    $host = "db.$projectRef.supabase.co"
    Write-Host "Usando Direct Connection (porta 5432)" -ForegroundColor Yellow
} else {
    $porta = "6543"
    $host = "aws-0-us-east-1.pooler.supabase.com"
    Write-Host "Usando Connection Pooling (porta 6543)" -ForegroundColor Yellow
}

# Construir a connection string
$connectionString = "postgresql://postgres.$projectRef`:$passwordPlain@$host`:$porta/postgres"

Write-Host ""
Write-Host "Connection String gerada:" -ForegroundColor Green
Write-Host $connectionString -ForegroundColor Cyan
Write-Host ""

# Atualizar o arquivo .env
if (-not (Test-Path ".env")) {
    Write-Host "ERRO: Arquivo .env não encontrado!" -ForegroundColor Red
    exit 1
}

$envContent = Get-Content .env -Raw

# Substituir a connection string
if ($envContent -match "DATABASE_CONNECTION_URI=.*") {
    $envContent = $envContent -replace "DATABASE_CONNECTION_URI=.*", "DATABASE_CONNECTION_URI=$connectionString"
    Write-Host "Connection string atualizada no arquivo .env!" -ForegroundColor Green
} else {
    $envContent += "`nDATABASE_CONNECTION_URI=$connectionString`n"
    Write-Host "Connection string adicionada ao arquivo .env!" -ForegroundColor Green
}

# Garantir que DATABASE_PROVIDER está configurado
if ($envContent -match "DATABASE_PROVIDER=.*") {
    $envContent = $envContent -replace "DATABASE_PROVIDER=.*", "DATABASE_PROVIDER=postgresql"
} else {
    $envContent += "`nDATABASE_PROVIDER=postgresql`n"
}

# Salvar o arquivo
Set-Content .env -Value $envContent

Write-Host ""
Write-Host "===========================================" -ForegroundColor Green
Write-Host "Configuração concluída!" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos passos:" -ForegroundColor Yellow
Write-Host "1. Execute: `$env:DATABASE_PROVIDER='postgresql'" -ForegroundColor White
Write-Host "2. Execute: npm run db:generate" -ForegroundColor White
Write-Host "3. Execute: npm run db:deploy:win" -ForegroundColor White
Write-Host ""

