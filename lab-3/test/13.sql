.headers on
select s_name, count(l_discount) as discounted_items
from lineitem, supplier
where l_discount = 0.10 and l_suppkey = s_suppkey
group by s_name