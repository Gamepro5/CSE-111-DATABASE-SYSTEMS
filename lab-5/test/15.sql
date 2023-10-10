.headers on
select max(l_discount) as "max_small_disc"
from lineitem, orders
where l_orderkey = o_orderkey and strftime('%Y', o_orderdate) = '1994' and strftime('%m', o_orderdate) = '10' and l_discount < (select avg(l_discount) from lineitem)

