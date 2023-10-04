.headers on
select n_name as country, o_orderstatus as status, count(o_orderkey) as orders
from customer, orders, nation, region
where c_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = "AFRICA" and o_custkey = c_custkey
group by o_orderstatus, n_name;