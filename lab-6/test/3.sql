.headers on
with 
african_suppliers as (select * from supplier, region, nation where s_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = "AFRICA"),
asian_customers as (select * from customer, nation, region where c_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = "ASIA")


select distinct p_name as "part"
from african_suppliers, asian_customers, partsupp, part, lineitem, orders
where c_custkey = o_orderkey and o_orderkey = l_orderkey and l_partkey = p_partkey and l_suppkey = s_suppkey and 3 = (select count(s_suppkey) from african_suppliers, lineitem where s_suppkey = l_suppkey and l_orderkey = o_orderkey)