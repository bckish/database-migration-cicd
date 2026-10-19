# Database Migration CI/CD

A local-first database delivery example using PostgreSQL and Flyway. Versioned SQL migrations are applied automatically to an ephemeral database and validated in GitHub Actions.

## Run locally

```bash
docker compose up --wait
docker compose exec postgres psql -U app -d app -c 'select * from customers;'
```

The Flyway container runs the migration files in order. Add new schema changes as immutable files under `migrations/`.

## Delivery rules

- Never edit an applied migration; create a new version.
- Test migrations against a production-like backup before release.
- Keep backwards compatibility during application rollout.
- Require a rollback plan for destructive changes.
