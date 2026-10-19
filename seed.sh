#!/usr/bin/env bash
# Create the `items`, `invoices` and `invoice_items` tables and load sample
# grocery items. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")"

if [ -f .env ]; then
  set -a; . ./.env; set +a
fi

# Order matters: invoices reference items.
for f in db/seed_items.sql db/invoices.sql; do
  docker compose exec -T postgres \
    psql -v ON_ERROR_STOP=1 \
         -U "${POSTGRES_USER:-app}" -d "${POSTGRES_DB:-app}" \
    < "$f"
done

echo
echo "items table now contains:"
docker compose exec -T postgres \
  psql -U "${POSTGRES_USER:-app}" -d "${POSTGRES_DB:-app}" \
  -c "SELECT count(*) AS items FROM items;"
