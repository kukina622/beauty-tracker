create table public.categories (
  id uuid not null default gen_random_uuid (),
  category_name character varying not null,
  category_icon integer not null,
  category_color bigint not null,
  "user" uuid null default auth.uid (),
  constraint categories_pkey primary key (id),
  constraint categories_user_fkey foreign KEY ("user") references auth.users (id) on update CASCADE on delete set null
) TABLESPACE pg_default;