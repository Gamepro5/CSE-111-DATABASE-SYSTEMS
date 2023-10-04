.headers on
select supp_region, cust_region, min(price1, price2) as min_price
from 	(select r_name as supp_region, o_totalprice as price1
		from orders, nation, region, lineitem, supplier
		where o_orderkey = l_orderkey and l_suppkey = s_suppkey and s_nationkey = n_nationkey and n_regionkey = r_regionkey
		group by r_name), 
		
		(select r_name as cust_region, o_totalprice as price2
		from orders, nation, region, lineitem, customer
		where o_orderkey = l_orderkey and c_custkey = o_custkey and c_nationkey = n_nationkey and n_regionkey = r_regionkey
		group by r_name)
where supp_region != cust_region;