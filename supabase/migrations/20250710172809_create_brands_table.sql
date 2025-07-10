create table public.brands (
  id uuid not null default gen_random_uuid (),
  brand_name character varying not null,
  "user" uuid null default auth.uid (),
  constraint brands_pkey primary key (id),
  constraint brands_user_fkey foreign KEY ("user") references auth.users (id) on update CASCADE on delete set null
) TABLESPACE pg_default;