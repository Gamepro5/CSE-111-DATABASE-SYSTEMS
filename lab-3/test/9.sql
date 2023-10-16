.headers on
Select strftime('%Y-%m', o_orderdate) as year_month, count(*) as items 
FROM customer 
join orders on o_custkey = c_custkey 
join lineitem on o_orderkey = l_orderkey 
where c_custkey = 227 
group by strftime('%Y-%m', o_orderdate);
