.headers on
select sum(o_totalprice) as total_price
from orders, customer, nation
where orders.o_custkey == customer.c_custkey and customer.c_nationkey == nation.n_nationkey and nation.n_regionkey == 1 and STRFTIME('%Y', orders.o_orderdate) == '1995';