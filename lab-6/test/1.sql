.headers on
select s_name as "supplier", c_name as "customer", o_totalprice as "price"
from orders, supplier, customer, lineitem
where o_custkey = c_custkey and o_orderkey = l_orderkey and l_suppkey = s_suppkey and o_orderstatus = "F" and o_totalprice = (select max(o_totalprice) from orders where o_orderstatus = 'F')
order by o_totalprice desc;