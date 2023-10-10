.headers on
select  total_france_rev/total_america_rev as "FRANCE_in_AMERICA_in_1994"
from (select sum(l_extendedprice*(1-l_discount)) as "total_france_rev" from supplier, nation, lineitem where s_nationkey = 6 and l_suppkey = s_suppkey and strftime('%Y', l_shipdate) = '1994'),
				(select sum(l_extendedprice*(1-l_discount)) as "total_america_rev" from customer, nation, lineitem, orders where c_nationkey = n_nationkey and n_regionkey = 1 and o_custkey = c_custkey and o_orderkey = l_orderkey and strftime('%Y', l_shipdate) = '1994')
