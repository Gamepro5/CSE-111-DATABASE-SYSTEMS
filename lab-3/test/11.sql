.headers on
select count(o_orderpriority) as order_cnt
from orders, customer, nation
where o_orderpriority = "1-URGENT" and c_custkey = o_custkey and c_nationkey == n_nationkey and n_name == "ROMANIA" and STRFTIME('%Y', o_orderdate) >= '1993' and STRFTIME('%Y', o_orderdate) <= '1997'