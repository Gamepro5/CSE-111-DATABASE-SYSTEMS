.headers on
SELECT total_imports1998_table.nation as country, total_exports1996-total_imports1996 as "1996", total_exports1998-total_imports1998 as "1998"
from 



(
SELECT n_name as "nation", sum(l_quantity) as total_exports1996
from supplier 
join nation on n_nationkey = s_nationkey
join region on r_regionkey = n_regionkey
join lineitem on l_suppkey = s_suppkey
join orders on o_orderkey = l_orderkey
where strftime('%Y', l_shipdate) = '1996'
group by n_name
) as total_exports1996_table
join 
(
select n_name as "nation", sum(l_quantity) as total_imports1996
from customer
join nation on n_nationkey = c_nationkey
join region on r_regionkey = n_regionkey

join orders on o_custkey = c_custkey
join lineitem on l_orderkey = o_orderkey
where strftime('%Y', l_shipdate) = '1996'
group by n_name
) as total_imports1996_table
on total_exports1996_table.nation = total_imports1996_table.nation

,

(
SELECT n_name as "nation", sum(l_quantity) as total_exports1998
from supplier 
join nation on n_nationkey = s_nationkey
join region on r_regionkey = n_regionkey
join lineitem on l_suppkey = s_suppkey
join orders on o_orderkey = l_orderkey
where strftime('%Y', l_shipdate) = '1998'
group by n_name
) as total_exports1998_table
join
(
select n_name as "nation", sum(l_quantity) as total_imports1998
from customer
join nation on n_nationkey = c_nationkey
join region on r_regionkey = n_regionkey

join orders on o_custkey = c_custkey
join lineitem on l_orderkey = o_orderkey
where strftime('%Y', l_shipdate) = '1998'
group by n_name
) as total_imports1998_table
on total_exports1998_table.nation = total_imports1998_table.nation

where total_exports1996_table.nation = total_exports1998_table.nation