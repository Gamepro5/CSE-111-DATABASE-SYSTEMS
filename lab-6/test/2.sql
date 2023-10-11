.headers on
with african_suppliers as (
select s_suppkey
from supplier, region, nation
where 
s_nationkey = n_nationkey
and
n_regionkey = r_regionkey
and 
r_name = "AFRICA"
)


select distinct c_custkey as "customer_cnt"
from orders, customer, lineitem, african_suppliers
where 	c_custkey = o_custkey 
		and 
		o_orderkey = l_orderkey
		and
		l_suppkey = s_suppkey


	
	;	