create table public.product_category (
  product_id uuid not null,
  category_id uuid not null,
  constraint product_category_pkey primary key (product_id, category_id),
  constraint product_category_category_id_fkey foreign KEY (category_id) references categories (id) on update CASCADE on delete CASCADE,
  constraint product_category_product_id_fkey foreign KEY (product_id) references products (id) on update CASCADE on delete CASCADE
) TABLESPACE pg_default;