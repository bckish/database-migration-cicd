create table customers (
  id bigserial primary key,
  email varchar(255) not null unique,
  created_at timestamptz not null default now()
);
