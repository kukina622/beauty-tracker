create table public.expiry_notification_records (
  id uuid not null default gen_random_uuid(),
  product_id uuid not null,
  notification_type text not null,
  sent_date date not null default NOW(),
  "user" uuid null default auth.uid (),
  constraint notifications_pkey primary key (id),
  constraint notifications_product_fkey foreign key (product_id) references products (id) on update cascade on delete cascade,
  constraint notifications_user_fkey foreign key ("user") references auth.users (id) on update cascade on delete cascade
);