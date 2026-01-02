const dotenv = require('dotenv');
const { execSync } = require('child_process');
const { existsSync } = require('fs');

// Preserve environment variables before loading .env
const envBeforeDotenv = { ...process.env };

// Load .env file if it exists (for local development)
// In Railway/Docker, this will be empty but won't override env vars
dotenv.config();

// Restore environment variables that might have been overwritten by .env
// This ensures Railway/Docker env vars take precedence
Object.keys(envBeforeDotenv).forEach(key => {
  if (envBeforeDotenv[key]) {
    process.env[key] = envBeforeDotenv[key];
  }
});

// Ensure DATABASE_CONNECTION_URI is available for Prisma
// Map DATABASE_URL to DATABASE_CONNECTION_URI if needed
if (!process.env.DATABASE_CONNECTION_URI && process.env.DATABASE_URL) {
  process.env.DATABASE_CONNECTION_URI = process.env.DATABASE_URL;
}
// Map DATABASE_CONNECTION_URI to DATABASE_URL if needed
if (!process.env.DATABASE_URL && process.env.DATABASE_CONNECTION_URI) {
  process.env.DATABASE_URL = process.env.DATABASE_CONNECTION_URI;
}

// Debug: Log if DATABASE_CONNECTION_URI is set (without showing the value)
if (process.env.DATABASE_CONNECTION_URI) {
  console.log('[runWithProvider] DATABASE_CONNECTION_URI is set');
} else {
  console.warn('[runWithProvider] WARNING: DATABASE_CONNECTION_URI is not set!');
}

const { DATABASE_PROVIDER } = process.env;
const databaseProviderDefault = DATABASE_PROVIDER ?? 'postgresql';

if (!DATABASE_PROVIDER) {
  console.warn(`DATABASE_PROVIDER is not set in the .env file, using default: ${databaseProviderDefault}`);
}

// Função para determinar qual pasta de migrations usar
// Função para determinar qual pasta de migrations usar
function getMigrationsFolder(provider) {
  switch (provider) {
    case 'psql_bouncer':
      return 'postgresql-migrations'; // psql_bouncer usa as migrations do postgresql
    default:
      return `${provider}-migrations`;
  }
}

const migrationsFolder = getMigrationsFolder(databaseProviderDefault);

let command = process.argv
  .slice(2)
  .join(' ')
  .replace(/DATABASE_PROVIDER/g, databaseProviderDefault);

// Substituir referências à pasta de migrations pela pasta correta
const migrationsPattern = new RegExp(`${databaseProviderDefault}-migrations`, 'g');
command = command.replace(migrationsPattern, migrationsFolder);

if (command.includes('rmdir') && existsSync('prisma\\migrations')) {
  try {
    execSync('rmdir /S /Q prisma\\migrations', { stdio: 'inherit' });
  } catch (error) {
    console.error(`Error removing directory: prisma\\migrations`);
    process.exit(1);
  }
} else if (command.includes('rmdir')) {
  console.warn(`Directory 'prisma\\migrations' does not exist, skipping removal.`);
}

try {
  // Ensure DATABASE_CONNECTION_URI is explicitly set for Prisma
  const env = {
    ...process.env,
    DATABASE_CONNECTION_URI: process.env.DATABASE_CONNECTION_URI || process.env.DATABASE_URL || '',
    DATABASE_URL: process.env.DATABASE_URL || process.env.DATABASE_CONNECTION_URI || '',
  };

  // Pass environment variables to the command
  execSync(command, { 
    stdio: 'inherit',
    env: env
  });
} catch (error) {
  console.error(`Error executing command: ${command}`);
  console.error(`DATABASE_CONNECTION_URI: ${process.env.DATABASE_CONNECTION_URI ? 'SET' : 'NOT SET'}`);
  console.error(`DATABASE_URL: ${process.env.DATABASE_URL ? 'SET' : 'NOT SET'}`);
  process.exit(1);
}