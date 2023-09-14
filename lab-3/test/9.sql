.headers on
select o_orderdate as year_month, l_quantity as items
from orders, customer, lineitem
where o_custkey == c_custkey and customer.c_name == "Customer#000000227" and l_orderkey == o_orderkey
