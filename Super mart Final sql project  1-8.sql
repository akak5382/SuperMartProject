
---------------Table 1: This table presents the status of category level view:


select
Y.category,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores













from
(select 
X.category,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
ph.category,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.product_hierarchy as ph
on ph.product_id=od.product_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
group by 1) Y;




--------- Table 2: This table presents the status of Sub Category and Category Level View:


select
Y.category,
Y.sub_category,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores













from
(select 
X.category,
X.sub_category,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
ph.sub_category,
ph.category,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.product_hierarchy as ph
on ph.product_id=od.product_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
group by 1,2) Y


----- Table 3: This table presents the status of Top 30 Brand Level View by MTD Orders:

select
Y.brand,
Y.category,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores













from
(select 
X.category,
X.brand,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
ph.brand,
ph.category,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.product_hierarchy as ph
on ph.product_id=od.product_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
group by 1,2) Y
order by MTD_orders desc
limit 30;


-----------Table 4: This table presents the status of Top 50 Product Level View by MTD Orders:

select
Y.product_id,
Y.product,
Y.brand,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores













from
(select 
X.product_id,
X.product,
X.brand,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
ph.product,
ph.brand,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.product_hierarchy as ph
on ph.product_id=od.product_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
group by 1,2,3) Y
order by MTD_orders desc
limit 50;


---------------Table 5: This table presents the status of StoreType Level View:


select
Y.storetype_id,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores



from
(select 
X.storetype_id,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
sc.storetype_id,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.Store_cities as sc
on sc.store_id=od.store_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
Group by 1)Y


------------------Table 6: This table presents the status of Top 50 Store_Id Level View by MTD Orders:

select
Y.store_id,
Y.storetype_id,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores



from
(select 
X.storetype_id,
X.store_id,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
sc.storetype_id,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.Store_cities as sc
on sc.store_id=od.store_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
Group by 1,2)Y
order by MTD_orders desc
limit 50;



-------------Table 7: This table presents the status of State Level View:



select
Y.state,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores



from
(select 
X.state,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
sc.state,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.Store_cities as sc
on sc.store_id=od.store_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
Group by 1)Y





-------------Table 8: This table presents the status of Top 50 City Level View by MTD Orders:


select
Y.city,
Y.store_id as Store,
t1_orders as Yday_orders,
Coalesce(round((t1_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as Yday_orders_Growth,
t1_GMV as Yday_GMV,
Coalesce(round((t1_GMV-t2_GMV)/nullif (t2_GMV,0)*100,2),0) as Yday_GMV_Growth,
t1_Revenue as Yday_revenue,
Coalesce(round((t1_Revenue-t2_Revenue)/nullif (t2_Revenue,0)*100,2),0) as Yday_Revenue_growth,
t1_customers as Yday_customer,
Coalesce(round((t1_customers-t2_customers)/nullif (t2_customers,0)*100,2),0) as Yday_customer_growth,
t1_New_customer as Yday_New_customer,
Coalesce(round((t1_New_customer-t2_New_customer)/nullif (t2_New_customer,0)*100,2),0) as Yday_new_customer_growth,
t1_Live_product as Yday_live_products,
t1_Live_stores as Yday_live_stores,

MTD_orders,
Coalesce(round((MTD_orders-t2_orders)/nullif (t2_orders,0)*100,2),0) as MTD_orders_Growth,
MTD_GMV,
Coalesce(round((MTD_GMV-LMTD_GMV)/nullif (LMTD_GMV,0)*100,2),0) as MTD_GMV_Growth,
MTD_Revenue,
Coalesce(round((MTD_Revenue-LMTD_Revenue)/nullif (LMTD_Revenue,0)*100,2),0) as MTD_Revenue_growth,
MTD_customers,
Coalesce(round((MTD_customers-LMTD_customers)/nullif (LMTD_customers,0)*100,2),0) as MTD_customer_growth,
MTD_New_customer,
Coalesce(round((MTD_New_customer-LMTD_New_customer)/nullif (LMTD_New_customer,0)*100,2),0) as MTD_new_customer_growth,
MTD_Live_product,
MTD_Live_stores,
LM_orders,
LM_GMV,
LM_Revenue,
LM_customers,
LM_New_customer,
LM_Live_product,
LM_live_stores



from
(select 
X.city,
X.store_id,
Coalesce(count(distinct case when order_date="2024-09-15" then X.order_id end),0) as t1_orders,
Coalesce(count(distinct case when order_date="2024-09-14" then X.order_id end),0) as t2_orders,
Coalesce(sum(case when order_date="2024-09-15" then x.gmv end),0) as t1_GMV,
Coalesce(sum(case when order_date="2024-09-14" then x.gmv end),0) as t2_GMV,
round (Coalesce(sum(case when order_date="2024-09-15" then x.gmv end)/1.18,0),0) as t1_Revenue,
round (Coalesce(sum(case when order_date="2024-09-14" then x.gmv end)/1.18,0),0) as t2_Revenue,
Coalesce(count(distinct case when order_date="2024-09-15" then X.customer_id end),0) as t1_customers,
Coalesce(count(distinct case when order_date="2024-09-14" then X.customer_id end),0) as t2_customers,
Coalesce(count(distinct case when order_date="2024-09-15" then X.product_id end),0) as t1_Live_product,
Coalesce(count(distinct case when order_date="2024-09-14" then X.product_id end),0) as t2_Live_product,
Coalesce(count(distinct case when order_date="2024-09-15" then X.store_id end),0) as t1_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-14" then X.store_id end),0) as t2_Live_stores,
Coalesce(count(distinct case when order_date="2024-09-15" then X.New_customer_id end),0) as t1_New_customer,
Coalesce(count(distinct case when order_date="2024-09-14" then X.New_customer_id end),0) as t2_New_customer,


Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.order_id end),0) as MTD_orders,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end),0),0) as MTD_GMV,
round (Coalesce(sum(case when order_date between "2024-09-01" and "2024-09-15" then x.gmv end)/1.18,0),0) as MTD_Revenue,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.customer_id end),0) as MTD_customers,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.product_id end),0) as MTD_Live_product,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.store_id end),0) as MTD_Live_stores,
Coalesce(Count(distinct case when order_date between "2024-09-01" and "2024-09-15" then X.New_customer_id end),0) as MTD_New_customer,

Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.order_id end),0) as LMTD_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end),0),0) as LMTD_GMV,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-15" then x.gmv end)/1.18,0),0) as LMTD_Revenue,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.customer_id end),0) as LMTD_customers,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.product_id end),0) as LMTD_Live_product,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.store_id end),0) as LMTD_Live_stores,
Coalesce(count(distinct case when order_date between "2024-08-01" and "2024-08-15" then X.New_customer_id end),0) as LMTD_New_customer,

Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.order_id end),0) as LM_orders,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end)/1.18,0),0) as LM_Revenue,
round (Coalesce(sum(case when order_date between "2024-08-01" and "2024-08-30" then x.gmv end),0),0) as LM_GMV,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.customer_id end),0) as LM_customers,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.product_id end),0) as LM_Live_product,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.store_id end),0) as LM_Live_stores,
Coalesce(count(distinct case when order_date between '2024-08-01' and '2024-08-30' then x.New_customer_id end),0) as LM_New_customer


from
(select
sc.city,
od.product_id,
od.order_id,
od.selling_price as GMV,
od.customer_id,
od.store_id,
od.order_date,
B.customer_id as New_customer_id
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.Store_cities as sc
on sc.store_id=od.store_id
left join (select*
from 
(select
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by customer_id order by order_date asc) as RNK
from datascience-434309.super_mart.order_details as od) as new_c
where new_c.RNK=1) as B
on od.customer_id=B.customer_id)X
Group by 1,2)Y

