alter table customers
  add constraint customers_status_valid check (status in ('active', 'disabled'));

create index customers_status_idx on customers (status);
