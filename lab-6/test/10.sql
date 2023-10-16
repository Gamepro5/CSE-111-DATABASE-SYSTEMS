.headers on
select n_name as "country"
from nation
join customer on n_nationkey = c_nationkey
join orders on c_custkey = o_custkey
where c_custkey = (select c_custkey from orders join customer on o_custkey = c_custkey group by c_custkey order by sum(o_totalprice) desc limit 1)
group by c_custkey;