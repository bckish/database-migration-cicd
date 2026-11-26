#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
project="migration-lab-$(date +%s)-$$"
c(){ docker compose -p "$project" "$@"; }
trap 'c down -v >/dev/null 2>&1' EXIT
c up -d --wait postgres
c run --rm flyway
c run --rm flyway
query(){ c exec -T postgres psql -U app -d app -v ON_ERROR_STOP=1 -Atc "$1"; }
test "$(query 'select count(*) from flyway_schema_history where success and version is not null;')" = 3
test "$(query 'select count(*) from customers;')" = 1
test "$(query "select status from customers where email='demo@example.com';")" = active
test "$(query "select count(*) from pg_constraint where conname='customers_status_valid';")" = 1
if query "insert into customers(email,status) values ('invalid@example.com','invalid');"; then
  echo 'Invalid status unexpectedly accepted' >&2; exit 1
fi
echo 'PASS: all three migrations, replay idempotency, seed data, schema constraint'
