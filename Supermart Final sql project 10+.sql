select
case
when YD.orders_count=1 then '1' 
when YD.orders_count=2 then '2'
when YD.orders_count=3 then '3'
when YD.orders_count=4 then '4'
when YD.orders_count=5 then '5'
when YD.orders_count >5 and YD.orders_count<=7 then '6 to 7'
when YD.orders_count >7 and YD.orders_count<=10 then '8 to 10'
when YD.orders_count>10 then 'gtr10' end as order_range,

COUNT(DISTINCT YD.customer_id) AS Yesterday_Customers,
SUM(YD.orders_count) AS Yesterday_Orders,
COUNT(DISTINCT MD.customer_id) AS MTD_Customers,
SUM(MD.orders_count) AS MTD_Orders,
COUNT(DISTINCT LM.customer_id) AS LM_Customers,
SUM(LM.orders_count) AS LM_Orders

FROM 
(SELECT customer_id,
COUNT(DISTINCT order_id) as orders_count
FROM datascience-434309.super_mart.order_details
WHERE order_date = '2024-09-15'
GROUP BY customer_id) as YD

LEFT JOIN (SELECT customer_id,
COUNT(DISTINCT order_id) AS orders_count
FROM datascience-434309.super_mart.order_details
WHERE order_date BETWEEN '2024-09-01' AND '2024-09-15'
GROUP BY customer_id) as MD ON YD.customer_id = MD.customer_id

LEFT JOIN (SELECT customer_id,
COUNT(DISTINCT order_id) AS orders_count
FROM datascience-434309.super_mart.order_details
WHERE order_date BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY customer_id) lm ON yd.customer_id = lm.customer_id
GROUP BY Order_Range
ORDER BY Order_Range;