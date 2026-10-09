# CLAUDE.md

Local PostgreSQL 17 (Docker) holding data for an online grocery shopping web application demo. See [README.md](README.md) for user-facing usage.

## Layout

- `docker-compose.yml`: single `postgres` service, container `kz-cr-db-psql`, data in the `pgdata` named volume.
- `run.sh`: starts the container with `docker compose up -d --wait` and prints the connection string.
- `seed.sh`: pipes `db/seed_items.sql` into the running container via `docker compose exec -T postgres psql`.
- `db/seed_items.sql`: creates the `items` table and upserts ~50 sample grocery items.
- `.env.example`: overridable settings (`POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`, `POSTGRES_PORT`). `.env` is git-ignored.

## Conventions and decisions

- **Defaults live in the scripts, not just `.env`.** Every script and the compose file use `${VAR:-default}` (`app` / `app_password` / `app` / `5432`), so everything works with no `.env`. Keep new scripts consistent: source `.env` if present, then use the same fallbacks.
- **Loopback only.** The port is bound to `127.0.0.1`. Don't widen it. Credentials are for local testing only.
- **Credentials apply only on first volume creation.** Changing them in `.env` has no effect on an existing `pgdata` volume; use `docker compose down -v` to reset (this deletes data).
- **Scripts are bash with `set -euo pipefail`** and `cd "$(dirname "$0")"` so they run from any directory.
- **SQL must be idempotent.** Use `CREATE TABLE IF NOT EXISTS` and `INSERT ... ON CONFLICT (...) DO UPDATE`, wrapped in a transaction. Seed runs use `psql -v ON_ERROR_STOP=1` so a failure aborts instead of partially applying.
- **`items` table:** `id` (identity PK), `name` (`TEXT`, unique, the upsert key), `description` (`TEXT`), `price` (`NUMERIC(10,2)`, `CHECK >= 0`). Money is `NUMERIC`, never float.
- **Upsert key is `name`.** Renaming an item in the seed file creates a new row and leaves the old one behind; removing an item from the file does not delete it.
- Seed data is purely sample data; prices and descriptions are invented.

## Verifying changes

1. `./run.sh` (container must be healthy).
2. `./seed.sh` twice; the row count must be identical both times.
3. Inspect with `docker compose exec postgres psql -U app -d app -c 'SELECT * FROM items LIMIT 5;'`.

## Notes for future work

- Schema changes: add new SQL files under `db/` and a matching script, rather than overloading `seed_items.sql`. If the schema starts changing often, consider a migration tool instead of ad-hoc scripts.
- Update the README and this file when adding scripts or tables.
