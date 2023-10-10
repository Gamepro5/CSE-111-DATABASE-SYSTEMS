.headers on
select o_orderpriority as "priority", count(DISTINCT o_orderkey) as "order_cnt"
from orders, lineitem
where l_receiptdate > l_commitdate and o_orderkey = l_orderkey and strftime('%Y', o_orderdate) = '1995'
group by o_orderpriority;