.headers on
select country, cnt
from (select n_name as country, count (o_orderkey) as cnt
		from lineitem, orders, nation, supplier, region
		where o_orderstatus = "F" and STRFTIME('%Y', orders.o_orderdate) == '1993' and n_regionkey = r_regionkey and r_name = "AFRICA" and o_orderkey = l_orderkey and l_suppkey = s_suppkey and s_nationkey = n_nationkey
		group by n_name)
where cnt > 200
group by country;