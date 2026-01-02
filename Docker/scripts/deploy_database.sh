#!/bin/bash

source ./Docker/scripts/env_functions.sh

if [ "$DOCKER_ENV" != "true" ]; then
    export_env_vars
fi

if [[ "$DATABASE_PROVIDER" == "postgresql" || "$DATABASE_PROVIDER" == "mysql" || "$DATABASE_PROVIDER" == "psql_bouncer" ]]; then
    # Map DATABASE_CONNECTION_URI to DATABASE_URL if DATABASE_URL is not set
    if [ -z "$DATABASE_URL" ] && [ -n "$DATABASE_CONNECTION_URI" ]; then
        export DATABASE_URL="$DATABASE_CONNECTION_URI"
    fi
    # Ensure DATABASE_CONNECTION_URI is available for Prisma schema
    if [ -z "$DATABASE_CONNECTION_URI" ] && [ -n "$DATABASE_URL" ]; then
        export DATABASE_CONNECTION_URI="$DATABASE_URL"
    fi
    export DATABASE_URL
    export DATABASE_CONNECTION_URI
    echo "Deploying migrations for $DATABASE_PROVIDER"
    echo "Database URL: $DATABASE_URL"
    # rm -rf ./prisma/migrations
    # cp -r ./prisma/$DATABASE_PROVIDER-migrations ./prisma/migrations
    npm run db:deploy
    if [ $? -ne 0 ]; then
        echo "Migration failed"
        exit 1
    else
        echo "Migration succeeded"
    fi
    npm run db:generate
    if [ $? -ne 0 ]; then
        echo "Prisma generate failed"
        exit 1
    else
        echo "Prisma generate succeeded"
    fi
else
    echo "Error: Database provider $DATABASE_PROVIDER invalid."
    exit 1
fi
