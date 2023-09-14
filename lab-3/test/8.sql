.headers on
select nation.n_name
from orders, customer, nation
where STRFTIME('%Y', orders.o_orderdate) == '1994' and STRFTIME('%m', orders.o_orderdate) == '12' and orders.o_custkey == customer.c_custkey and customer.c_nationkey == nation.n_nationkey
group by nation.n_name