.headers on
select n_name as country, count(distinct c_custkey) as cust_cnt, count(distinct s_suppkey) as supp_cnt
from nation, supplier, customer, region
where c_nationkey = n_nationkey and s_nationkey = n_nationkey and n_regionkey = 1
group by n_nationkey;