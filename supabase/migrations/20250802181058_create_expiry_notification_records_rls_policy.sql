alter table public.expiry_notification_records enable row level security;
create policy "Allow authenticated users to manage expiry_notification_records" on public.expiry_notification_records
for all using (
  auth.uid() = expiry_notification_records.user
);