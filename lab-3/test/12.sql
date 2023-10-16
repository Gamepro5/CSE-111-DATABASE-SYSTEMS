.headers on
Select  STRFTIME('%Y', o_orderdate) as year, count(l_quantity) as item_cnt
From lineitem
join supplier on s_suppkey = l_suppkey
join nation on n_nationkey = s_nationkey
join orders on l_orderkey = o_orderkey 
where ( n_name = 'ARGENTINA' or n_name = 'BRAZIL') and o_orderpriority = '3-MEDIUM' 
group by STRFTIME('%Y', o_orderdate);