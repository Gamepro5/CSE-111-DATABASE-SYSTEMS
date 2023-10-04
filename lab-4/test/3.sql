.headers on
select c_name as customer, sum(o_totalprice) as total_price
from customer, nation, orders
where c_custkey = o_custkey and c_nationkey = n_nationkey and n_name == "ARGENTINA" and STRFTIME('%Y', orders.o_orderdate) == '1996'
group by c_name