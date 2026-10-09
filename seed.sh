#!/usr/bin/env bash
# Create the `items` table and load sample grocery items. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")"

if [ -f .env ]; then
  set -a; . ./.env; set +a
fi

docker compose exec -T postgres \
  psql -v ON_ERROR_STOP=1 \
       -U "${POSTGRES_USER:-app}" -d "${POSTGRES_DB:-app}" \
  < db/seed_items.sql

echo
echo "items table now contains:"
docker compose exec -T postgres \
  psql -U "${POSTGRES_USER:-app}" -d "${POSTGRES_DB:-app}" \
  -c "SELECT count(*) AS items FROM items;"
