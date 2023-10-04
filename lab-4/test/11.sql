.headers on
select count(distinct(o_orderkey)) as order_cnt
from customer, supplier, orders, lineitem
where c_custkey = o_custkey and o_orderkey = l_orderkey and l_suppkey = s_suppkey and s_acctbal > 0 and c_acctbal < 0;