# Database Migration CI/CD

A local-first database delivery example using PostgreSQL and Flyway. Versioned SQL migrations are applied automatically to an ephemeral database and validated in GitHub Actions.

## Run locally

```bash
bash scripts/verify.sh
```

The script starts a uniquely named disposable PostgreSQL 16 stack, runs Flyway twice, verifies all three migration history records and the synthetic seed row, tests the status constraint, then removes only its test containers and volumes. No database port is bound on the host. Flyway OSS 13.13.0 Alpine is pinned with explicit migration locations.

## Delivery rules

- Never edit an applied migration; create a new version.
- Test migrations against a production-like backup before release.
- Keep backwards compatibility during application rollout.
- Require a rollback plan for destructive changes.

Verified 26 November 2026: native Apple Silicon Docker, Flyway 13.13.0, PostgreSQL 16.16. All three migrations applied, replay reported the schema up to date, the single synthetic seed remained intact, and an invalid status was rejected. No deprecation or platform mismatch warning was observed in the updated run. No live databases were contacted.
