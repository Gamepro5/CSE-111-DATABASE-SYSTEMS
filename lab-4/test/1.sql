.headers on
select n_name as country, count(o_orderkey) as cnt
from orders, customer, nation, region
where c_custkey = o_custkey and c_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = "EUROPE"
group by n_name