.headers on
with orders_in_november1995 as (

select * from orders where strftime('%m', o_orderdate) = '11' and strftime('%Y', o_orderdate) = '1995'

)

select count(c_custkey) as "customer_cnt"
from customer, orders_in_november1995
where o_custkey = c_custkey and 3 >= (select count(o_orderkey) from orders_in_november1995 where o_custkey = c_custkey)

;