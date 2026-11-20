--operation A
SELECT full_name,country,os.id as order_id,order_date
FROM public.customers cs
INNER JOIN public.orders os on cs.id=os.customer_id;

--operation B
SELECT full_name,country, sum(oi.unit_price*oi.quantity)
FROM public.customers cs 
INNER JOIN public.orders os on cs.id=os.customer_id
INNER JOIN public.order_items oi on oi.order_id=os.id
WHERE os.status like 'COMPLETED'
GROUP BY cs.full_name,country;

--operation C
SELECT full_name, sum(oi.unit_price*oi.quantity) as "suma"
FROM public.customers cs 
INNER JOIN public.orders os on cs.id=os.customer_id
INNER JOIN public.order_items oi on oi.order_id=os.id
WHERE os.status like 'COMPLETED'
GROUP BY cs.full_name
HAVING sum(oi.unit_price*oi.quantity)>300;

--operation D
DROP VIEW if EXISTS v_customer_revenue;

CREATE VIEW v_customer_revenue AS
SELECT full_name,country, sum(oi.unit_price*oi.quantity)
FROM public.customers cs 
INNER JOIN public.orders os on cs.id=os.customer_id
INNER JOIN public.order_items oi on oi.order_id=os.id
WHERE os.status like 'COMPLETED'
GROUP BY cs.full_name,country;

SELECT * from v_customer_revenue where country = 'USA';
