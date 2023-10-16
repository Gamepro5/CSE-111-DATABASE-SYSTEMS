.headers on
select l_partkey, count(distinct l_suppkey) as p
from lineitem
group by l_partkey
order by p