--1 up
create table users (
  id serial primary key,
  email citext not null unique,
  username citext not null unique,
  created_at timestamp with time zone not null,
  last_login_at timestamp with time zone,
  password_hash text,
  password_reset_code text,
  password_reset_expire timestamp with time zone
);

create table games (
  slug text not null primary key,
  name text not null
);

create table customs (
  id serial primary key,
  added_by integer not null references users (id),
  author integer references users (id),
  author_name text,
  game text not null references games (slug),
  added_at timestamp with time zone not null,
  title text not null,
  artist text not null,
  album text,
  track smallint,
  version integer not null default 1
);

--1 down
drop table users;
