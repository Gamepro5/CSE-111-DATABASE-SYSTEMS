.headers on
select supp_region, cust_region, strftime('%Y', l_shipdate) as year, (l_extendedprice*(1-l_discount)) as revenue
from lineitem, orders,	(
				select r_name as "supp_region", s_suppkey 
				from supplier, nation, region
				where s_nationkey = n_nationkey and n_regionkey = r_regionkey
				),
				(
				select r_name as "cust_region", c_custkey
				from customer, nation, region
				where c_nationkey = n_nationkey and n_regionkey = r_regionkey
				)
where strftime('%Y', l_shipdate) = '1994' or strftime('%Y', l_shipdate) = '1995' and supp_region != cust_region and s_suppkey = l_suppkey and l_orderkey = o_orderkey and o_custkey = c_custkey
group by supp_region, cust_region;