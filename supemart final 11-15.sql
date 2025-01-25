-------Table 11: This table presents the status of company level user type and ratio:

select 
'New_customer' as User_type,
New_customer as MTD_customer,
round((New_customer/MTD_customer)*100,2) as Ratio
from
(select
count(case when RNK=1 then customer_id end) as New_customer,
count(case when RNK>1 then customer_id end) as repeat_customer,
count(customer_id) as MTD_customer
from (select 
order_id,
customer_id,
order_date,
rank() over(partition by customer_id order by order_date) as RNK
from datascience-434309.super_mart.order_details) X
where order_date between "2024-10-01" and "2024-10-28") Y
union all
select 
'repeat_customer' as User_type,
repeat_customer as MTD_customer,
round((repeat_customer/MTD_customer)*100,2) as Ratio
from
(select
count(case when RNK=1 then customer_id end) as New_customer,
count(case when RNK>1 then customer_id end) as repeat_customer,
count(customer_id) as MTD_customer
from (select 
order_id,
customer_id,
order_date,
rank() over(partition by customer_id order by order_date) as RNK
from datascience-434309.super_mart.order_details) X
where order_date between "2024-10-01" and "2024-10-28") Y

--------Table 12: This table presents the status of category level user type and ratio:

select 
category,
'New_customer' as User_type,
New_customer as MTD_customer,
round((New_customer/MTD_customer)*100,2) as Ratio
from
(select
X.category,
count(case when RNK=1 then customer_id end) as New_customer,
count(case when RNK>1 then customer_id end) as repeat_customer,
count(customer_id) as MTD_customer
from (select
ph.category,
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by ph.category, od.customer_id order by od.order_date) as RNK
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.product_hierarchy as ph
on od.product_id=ph.product_id) X
where order_date between "2024-10-01" and "2024-10-28"
group by 1) Y
union all
select 
category,
'repeat_customer' as User_type,
repeat_customer as MTD_customer,
round((repeat_customer/MTD_customer)*100,2) as Ratio
from
(select
X.category,
count(case when RNK=1 then customer_id end) as New_customer,
count(case when RNK>1 then customer_id end) as repeat_customer,
count(customer_id) as MTD_customer
from (select
ph.category,
od.order_id,
od.customer_id,
od.order_date,
rank() over(partition by ph.category, od.customer_id order by od.order_date) as RNK
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.product_hierarchy as ph
on od.product_id=ph.product_id) X
where order_date between "2024-10-01" and "2024-10-28"
group by 1) Y
order by 1

--------Table 13: This table presents the status company level retention % of unique customers

select
SUBSTR(CAST(order_date as string),1,7) as month,
count(UC) as Unique_Customers,
count(case when order_date between '2023-09-01' and '2023-09-30' then UC end) as M1,
count(case when order_date between '2023-10-01' and '2023-10-31' then UC end) as M2,
count(case when order_date between '2023-11-01' and '2023-11-30' then UC end) as M3,
count(case when order_date between '2023-12-01' and '2023-12-31' then UC end) as M4,
count(case when order_date between '2024-01-01' and '2024-01-31' then UC end) as M5,
count(case when order_date between '2024-02-01' and '2024-02-29' then UC end) as M6,
count(case when order_date between '2024-03-01' and '2024-03-31' then UC end) as M7,
count(case when order_date between '2024-04-01' and '2024-04-30' then UC end) as M8,
count(case when order_date between '2024-05-01' and '2024-05-31' then UC end) as M9,
count(case when order_date between '2024-06-01' and '2024-06-30' then UC end) as M10,
count(case when order_date between '2024-07-01' and '2024-07-31' then UC end) as M11,
count(case when order_date between '2024-08-01' and '2024-08-30' then UC end) as M12

from (select distinct customer_id as UC,
order_date,
order_id
from datascience-434309.super_mart.order_details) X
where order_date between '2023-08-01' and '2024-06-30'
group by 1
order by 1

----------Table 14: This table presents the status company level retention % of new customers

select
SUBSTR(CAST(order_date as string),1,7) as month,
count(case when RNK=1 then customer_id end) as Total_New_Customers,
count(case when RNK=1 and order_date between '2023-09-01' and '2023-09-30' then customer_id end) as M1,
count(case when RNK=1 and order_date between '2023-10-01' and '2023-10-31' then customer_id end) as M2,
count(case when RNK=1 and order_date between '2023-11-01' and '2023-11-30' then customer_id end) as M3,
count(case when RNK=1 and order_date between '2023-12-01' and '2023-12-31' then customer_id end) as M4,
count(case when RNK=1 and order_date between '2024-01-01' and '2024-01-31' then customer_id end) as M5,
count(case when RNK=1 and order_date between '2024-02-01' and '2024-02-29' then customer_id end) as M6,
count(case when RNK=1 and order_date between '2024-03-01' and '2024-03-31' then customer_id end) as M7,
count(case when RNK=1 and order_date between '2024-04-01' and '2024-04-30' then customer_id end) as M8,
count(case when RNK=1 and order_date between '2024-05-01' and '2024-05-31' then customer_id end) as M9,
count(case when RNK=1 and order_date between '2024-06-01' and '2024-06-30' then customer_id end) as M10,
count(case when RNK=1 and order_date between '2024-07-01' and '2024-07-31' then customer_id end) as M11,
count(case when RNK=1 and order_date between '2024-08-01' and '2024-08-30' then customer_id end) as M12

from (select customer_id,
order_date,
order_id,
rank() over (partition by customer_id order by order_date) as RNK
from datascience-434309.super_mart.order_details) X
where order_date between '2023-08-01' and '2024-06-30'
group by 1
order by 1

---------Table 15: This table presents the status category level retention % of new customers/unique customers

select
category,
SUBSTR(CAST(order_date as string),1,7) as month,
Unique_Customers,
count(case when order_date between '2023-09-01' and '2023-09-30' then Unique_Customers end) as M1,
count(case when order_date between '2023-10-01' and '2023-10-31' then Unique_Customers end) as M2,
count(case when order_date between '2023-11-01' and '2023-11-30' then Unique_Customers end) as M3,
count(case when order_date between '2023-12-01' and '2023-12-31' then Unique_Customers end) as M4,
count(case when order_date between '2024-01-01' and '2024-01-31' then Unique_Customers end) as M5,
count(case when order_date between '2024-02-01' and '2024-02-29' then Unique_Customers end) as M6,
count(case when order_date between '2024-03-01' and '2024-03-31' then Unique_Customers end) as M7,
count(case when order_date between '2024-04-01' and '2024-04-30' then Unique_Customers end) as M8,
count(case when order_date between '2024-05-01' and '2024-05-31' then Unique_Customers end) as M9,
count(case when order_date between '2024-06-01' and '2024-06-30' then Unique_Customers end) as M10,
count(case when order_date between '2024-07-01' and '2024-07-31' then Unique_Customers end) as M11,
count(case when order_date between '2024-08-01' and '2024-08-30' then Unique_Customers end) as M12

from(select
order_date,
category,
count(UC) as Unique_Customers,
from (select distinct od.customer_id as UC,
ph.category,
od.order_id,
od.customer_id,
od.order_date
from datascience-434309.super_mart.order_details as od
join datascience-434309.super_mart.product_hierarchy as ph
on od.product_id=ph.product_id)X
group by 1,2)X
where order_date between '2023-08-01' and '2024-06-30'
group by 1,2,3
order by 1,2