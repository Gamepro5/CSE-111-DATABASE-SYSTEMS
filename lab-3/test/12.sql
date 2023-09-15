.headers on
select STRFTIME('%Y', o_orderdate) as year, sum(l_quantity) as item_cnt
from orders, customer, nation, lineitem
where o_orderpriority = "3-MEDIUM" and c_custkey = o_custkey and c_nationkey == n_nationkey and (n_name == "ARGENTINA" or n_name == "BRAZIL") and o_orderkey == l_orderkey
group by STRFTIME('%Y', o_orderdate)