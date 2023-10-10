.headers on
select count(distinct temp) as cust_cnt
from	(	select c_custkey as "temp"
			from customer, nation, region
			where 	c_nationkey = n_nationkey and n_regionkey = r_regionkey
					and
					(r_name != "EUROPE" and r_name != "ASIA")
		)