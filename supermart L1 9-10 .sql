
-------Table 9: This table present the status on Txn Range Level View - MTD  View:

select
Txn_Amount_Range,
MTD_customer,
MTD_order,
Coalesce(MTD_GMVs,0) as MTD_GMV,
Coalesce(round((MTD_GMVs/MTD_customer)*100),2,0) as MTD_GMV_By_Customers,
Coalesce(round((MTD_GMVs/MTD_order)*100),2,0) as MTD_GMV_By_order
from (select 
case when X.MTD_GMV between 1 and 1000 then '1 to 1000'
when X.MTD_GMV between 1001 and 2000 then '1001 to 2000'
when X.MTD_GMV between 2001 and 3000 then '2001 to 3000'
when X.MTD_GMV between 3001 and 4000 then '3001 to 4000'
when X.MTD_GMV between 4001 and 5000 then '4001 to 5000'
else '5000+'
end as Txn_Amount_Range,
count(distinct(X.MTD_customers)) as MTD_customer,
count(X.MTD_orders) as MTD_order,
sum(X.MTD_GMV) as MTD_GMVs

from
(select
count(case when order_date between "2024-09-01" and "2024-09-15" then customer_id end) as MTD_customers,
case when order_date between "2024-09-01" and "2024-09-15" then order_id end as MTD_orders,
sum(case when order_date between "2024-09-01" and "2024-09-15" then selling_price end) as MTD_GMV
from datascience-434309.super_mart.order_details
group by 2) as X
group by 1
order by 1)


------ Table 10: This table present the status on Txn Range Level View - MTD  View:

select
Order_Range,
MTD_customer,
MTD_order,
Coalesce(MTD_GMVs,0) as MTD_GMV,
Coalesce(round((MTD_GMVs/MTD_customer)*100),2,0) as MTD_GMV_By_Customers,
Coalesce(round((MTD_GMVs/MTD_order)*100),2,0) as MTD_GMV_By_order
from 
(select 
case when X.MTD_orders = 1 then '1'
when X.MTD_orders = 2 then '2'
when X.MTD_orders = 3 then '3'
when X.MTD_orders = 4 then '4'
when X.MTD_orders = 5 then '5'
else '5+'
end as Order_Range,
count(distinct(X.MTD_customers)) as MTD_customer,
count(X.MTD_orders) as MTD_order,
sum(X.MTD_GMV) as MTD_GMVs

from
(select
case when order_date between "2024-09-01" and "2024-09-15" then customer_id end as MTD_customers,
count(case when order_date between "2024-09-01" and "2024-09-15" then order_id end) as MTD_orders,
sum(case when order_date between "2024-09-01" and "2024-09-15" then selling_price end) as MTD_GMV
from datascience-434309.super_mart.order_details
group by 1) as X
group by 1
order by 1);



-----------Table 11





select 
A.month,
A.orders,
A.GMV,
A.Revenue,
A.customers,
Avg_Order_per_Customers,
Avg_GMV_per_Customers,
count(new_customer) as new_customers,
count(repeat_customer) as repeat_customers


from 
(select 
concat (EXTRACT(month from order_date),'-',EXTRACT(year from order_date)) as month,
count(X.order_id) as orders,
sum(X.selling_price) as GMV,
sum(X.selling_price)/1.18 as Revenue,
count(X.customer_id) as Customers,
coalesce (count(X.order_id)/count(distinct(X.customer_id)),0) as Avg_Order_per_Customers,
sum(X.selling_price)/count(distinct(X.customer_id)) as Avg_GMV_per_Customers,
case when X.RNK=1 then X.customer_id end as new_customer,
case when X.RNK>1 then X.customer_id end as repeat_customer

from
(select
customer_id,
product_id,
store_id,
selling_price,
order_date,
order_id,
rank() over (partition by customer_id order by order_date desc) as RNK
from datascience-434309.super_mart.order_details) X
group by 1,8,9) A
group by 1,2,3,4,5,6,7