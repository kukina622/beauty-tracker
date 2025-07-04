create table public.products (
  id uuid not null default gen_random_uuid (),
  name character varying not null,
  brand character varying null,
  price numeric null,
  purchase_date date null,
  expiry_date date null,
  "user" uuid null default auth.uid (),
  status text null,
  constraint products_pkey primary key (id),
  constraint products_user_fkey foreign KEY ("user") references auth.users (id) on update CASCADE on delete set null
) TABLESPACE pg_default;