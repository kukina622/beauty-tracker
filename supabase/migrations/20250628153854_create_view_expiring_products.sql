create or replace view public.products_in_use_expiring_in_30d with (security_invoker = on) as
select *
from public.products
where expiry_date is not null
  and expiry_date >= current_date
  and expiry_date <  current_date + interval '30 days'
  and status = 'inUse'