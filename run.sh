#!/usr/bin/env bash
# Start the local PostgreSQL container for testing.
set -euo pipefail
cd "$(dirname "$0")"

if [ -f .env ]; then
  set -a; . ./.env; set +a
fi

docker compose up -d --wait

echo
echo "PostgreSQL is ready:"
echo "  postgresql://${POSTGRES_USER:-app}:${POSTGRES_PASSWORD:-app_password}@127.0.0.1:${POSTGRES_PORT:-5432}/${POSTGRES_DB:-app}"
echo "Stop with: docker compose down   (add -v to delete data)"
