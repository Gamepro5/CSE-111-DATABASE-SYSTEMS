.headers on

/*Question doesn't even make gramatical sense. "exactly one suppliers"*/
select l_partkey, count(distinct l_suppkey) as p
from lineitem
group by l_partkey
order by p