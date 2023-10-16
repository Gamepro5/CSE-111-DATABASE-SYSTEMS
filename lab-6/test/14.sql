.headers on
SELECT total_imports_table.nation as country, total_exports-total_imports as economic_exchange
from 
(
SELECT n_name as "nation", sum(l_quantity) as total_exports
from supplier 
join nation on n_nationkey = s_nationkey
join region on r_regionkey = n_regionkey
join lineitem on l_suppkey = s_suppkey
join orders on o_orderkey = l_orderkey
where strftime('%Y', l_shipdate) = '1997'
group by n_name
) as total_exports_table

join 

(
select n_name as "nation", sum(l_quantity) as total_imports
from customer
join nation on n_nationkey = c_nationkey
join region on r_regionkey = n_regionkey

join orders on o_custkey = c_custkey
join lineitem on l_orderkey = o_orderkey
where strftime('%Y', l_shipdate) = '1997'
group by n_name
) as total_imports_table
on total_exports_table.nation = total_imports_table.nation

;