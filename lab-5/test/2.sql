.headers on
select o_orderpriority as priority, count(l_linenumber) as item_cnt
from (select * from orders where strftime('%Y', o_orderdate) = '1995'), lineitem
where o_orderkey = l_orderkey and l_receiptdate < l_commitdate
group by o_orderpriority;