.headers on
select strftime('%Y-%m', o_orderdate) as year_month, count(l_quantity) as items
from orders, customer, lineitem
where o_custkey == c_custkey and customer.c_name == "Customer#000000227" and l_orderkey == o_orderkey
group by strftime('%Y-%m', o_orderdate)
