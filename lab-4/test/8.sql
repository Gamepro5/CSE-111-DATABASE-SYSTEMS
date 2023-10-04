.headers on
select count(DISTINCT(o_clerk)) as clerks
from lineitem, orders, nation, supplier
where n_name = "PERU" and s_nationkey = n_nationkey and s_suppkey = l_suppkey and l_orderkey = o_orderkey;