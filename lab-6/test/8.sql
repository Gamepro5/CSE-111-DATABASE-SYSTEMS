.headers on
select count(orders_per_supplier) as "supplier_cnt"
from 
(select count(distinct o_orderkey) as "orders_per_supplier" 
from lineitem 
join supplier on l_suppkey = s_suppkey 
join orders on o_orderkey = l_orderkey 
join customer on c_custkey = o_custkey 
join nation on c_nationkey = n_nationkey 
where n_name = 'JORDAN' or n_name = 'EGYPT'
group by s_name)
where orders_per_supplier < 50;

