# kz-cr-db-psql

A PostgreSQL (community edition) database running in Docker. It is intended to store application data for upcoming services in this demo project.

The server is published only on the loopback interface (`127.0.0.1`), so it is reachable from the local machine but not from the network.

## Quick start

```sh
./run.sh
```

This starts the container with Docker Compose, waits for the healthcheck to pass, and prints the connection string.

Default connection (override via `.env`, see `.env.example`):

| Setting  | Value          |
|----------|----------------|
| Host     | `127.0.0.1`    |
| Port     | `5432`         |
| User     | `app`          |
| Password | `app_password` |
| Database | `app`          |

Connect with `psql`:

```sh
psql postgresql://app:app_password@127.0.0.1:5432/app
```

## Configuration

Copy `.env.example` to `.env` to change the user, password, database name, or host port. `.env` is git-ignored. Note the credentials are only applied the first time the data volume is created.

## Seeding the `items` table

```sh
./seed.sh
```

This creates the `items` table (if missing) and loads about 50 sample grocery items, then creates the invoice tables described below. The database container must already be running (`./run.sh`).

| Column        | Type            | Notes                          |
|---------------|-----------------|--------------------------------|
| `id`          | `BIGINT`        | Generated identity, primary key |
| `name`        | `TEXT`          | Required, unique               |
| `description` | `TEXT`          | Required                       |
| `price`       | `NUMERIC(10,2)` | Required, must be `>= 0`       |

The script is idempotent. Rows are matched on `name` and updated in place, so re-running it never creates duplicates. Edit [db/seed_items.sql](db/seed_items.sql) to change the sample data. Items removed from the file are not deleted from the table.

## Invoices

`./seed.sh` also creates two tables from [db/invoices.sql](db/invoices.sql) (no sample data):

`invoices`:

| Column             | Type            | Notes                           |
|--------------------|-----------------|---------------------------------|
| `id`               | `BIGINT`        | Generated identity, primary key |
| `invoice_date`     | `DATE`          | Required                        |
| `amount`           | `NUMERIC(10,2)` | Required, must be `>= 0`        |
| `delivery_address` | `TEXT`          | Required                        |

`invoice_items` is a join table linking invoices to items:

| Column       | Type            | Notes                                                   |
|--------------|-----------------|---------------------------------------------------------|
| `invoice_id` | `BIGINT`        | References `invoices(id)`; deleting an invoice deletes its lines |
| `item_id`    | `BIGINT`        | References `items(id)`; an item on an invoice can't be deleted |
| `quantity`   | `INTEGER`       | Required, must be `> 0`                                 |
| `unit_price` | `NUMERIC(10,2)` | Price at the time of sale, must be `>= 0`               |

The primary key is (`invoice_id`, `item_id`).

## Data and teardown

Data persists in the `pgdata` Docker volume.

```sh
docker compose down       # stop, keep data
docker compose down -v    # stop and delete data
```

The defaults are for local testing only; use real secrets for anything else.
