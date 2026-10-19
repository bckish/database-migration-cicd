alter table customers add column status varchar(32) not null default 'active';
insert into customers (email, status) values ('demo@example.com', 'active');
