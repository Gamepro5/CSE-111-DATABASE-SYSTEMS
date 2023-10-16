.headers on
select region2.r_name as supp_region, region1.r_name as cust_region, min(o_totalprice) as min_price
from customer customer1 
join nation nation1 on customer1.c_nationkey = nation1.n_nationkey
join region region1 on region1.r_regionkey = nation1.n_regionkey
join orders on o_custkey = c_custkey
join lineitem on l_orderkey = o_orderkey
join supplier supplier1 on supplier1.s_suppkey = l_suppkey
join nation nation2 on supplier1.s_nationkey = nation2.n_nationkey 
join region region2 on region2.r_regionkey = nation2.n_regionkey

group by region1.r_name, region2.r_regionkey;