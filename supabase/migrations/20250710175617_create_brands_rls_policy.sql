alter table public.brands enable row level security;

create policy "Allow authenticated users to manage brands" on public.brands
for all using (
  auth.uid() = brands.user
);