.headers on
select c_name as customer, count(o_orderkey) as cnt
from customer, nation, orders
where c_custkey = o_custkey and c_nationkey = n_nationkey and n_name == "EGYPT" and STRFTIME('%Y', orders.o_orderdate) == '1992'
group by c_name