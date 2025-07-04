alter table public.products enable row level security;
alter table public.categories enable row level security;
alter table public.product_category enable row level security;

create policy "Allow authenticated users to manage products" on public.products
for all using (
  auth.uid() = products.user
);

create policy "Allow authenticated users to manage categories" on public.categories
for all using (
  auth.uid() = categories.user
);

create policy "Allow authenticated users to manage product categories" on public.product_category
for all using (
  auth.uid() = product_category.user
);
