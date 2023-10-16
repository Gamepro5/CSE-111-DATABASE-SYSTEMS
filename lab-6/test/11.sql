.headers on
select r_name as "region"
from region, nation where n_nationkey = (select c_nationkey
from customer
join orders on c_custkey = o_orderkey
join lineitem on o_orderkey = l_orderkey
join supplier on c_nationkey = s_nationkey
group by c_custkey
order by sum(l_extendedprice) desc limit 1) and r_regionkey = n_regionkey;