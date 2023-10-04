.headers on
select count(o_orderkey) as items
from lineitem, supplier, nation, region, customer, orders
where c_custkey = o_custkey and o_orderkey = l_orderkey and l_suppkey = s_suppkey and c_nationkey = 14 and (s_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = "ASIA");