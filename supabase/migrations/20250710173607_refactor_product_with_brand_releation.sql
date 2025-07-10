-- Drop the existing view to allow for changes
DROP VIEW public.products_in_use_expiring_in_30d;

-- Remove the brand column from products and add a new brand column with uuid type
ALTER TABLE public.products DROP COLUMN brand;


-- Add a new column 'brand' of type uuid to the products table
ALTER TABLE public.products ADD COLUMN brand uuid;

-- Add a foreign key constraint to the new 'brand' column referencing the brands table
ALTER TABLE public.products
ADD CONSTRAINT products_brand_fkey FOREIGN KEY (brand) REFERENCES public.brands (id)
ON UPDATE CASCADE ON DELETE SET NULL;

-- Update the view to reflect the changes in the products table
create or replace view public.products_in_use_expiring_in_30d with (security_invoker = on) as
select *
from public.products
where expiry_date is not null
  and expiry_date >= current_date
  and expiry_date <  current_date + interval '30 days'
  and status = 'inUse'