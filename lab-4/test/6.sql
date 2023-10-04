.headers on
select s_name as supplier, o_orderpriority as priority, count(l_partkey) as parts
from supplier, nation, orders, partsupp, lineitem
where s_nationkey = n_nationkey and o_orderkey = l_orderkey and l_suppkey = s_suppkey and ps_partkey = l_partkey and ps_suppkey = s_suppkey and n_name = "INDONESIA"
group by o_orderpriority, s_name;