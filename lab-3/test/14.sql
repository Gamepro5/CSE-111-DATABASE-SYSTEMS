.headers on
select r_name, count(o_orderstatus) as order_cnt
from orders, customer, nation, region
where o_orderstatus = "F" and o_custkey = c_custkey and c_nationkey = n_nationkey and n_regionkey = r_regionkey
group by r_name