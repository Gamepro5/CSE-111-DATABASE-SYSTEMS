.headers on
select r_name as region, count(distinct c_custkey) as cust_cnt
from  orders, customer, nation, region
where 
	c_custkey = o_custkey and c_nationkey = n_nationkey and n_regionkey = r_regionkey
	and 
	c_acctbal > (select AVG(c_acctbal) from customer)
group by r_name;