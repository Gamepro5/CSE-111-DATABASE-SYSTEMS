.headers on
with customers_per_country as(select n_name as "country", count(distinct c_custkey) as "cust_count"
from customer
join nation on n_nationkey = c_nationkey
group by n_nationkey
order by cust_count desc)

select country
from customers_per_country
where cust_count = (select max(cust_count) from customers_per_country)