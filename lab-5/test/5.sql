.headers on
select p_name as part
from lineitem, part
where 
	l_partkey = p_partkey
	and
	l_shipdate > '1993-10-2'
	and
	(l_extendedprice*(1-l_discount)) = (select max(l_extendedprice*(1-l_discount)) as price from lineitem);