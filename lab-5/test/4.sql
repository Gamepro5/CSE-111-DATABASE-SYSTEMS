.headers on
select count(distinct s_suppkey) as supp_cnt
from supplier, partsupp, part
where 
	s_suppkey = ps_suppkey
	and 
	ps_partkey = p_partkey 
	and 
	p_type like '%POLISHED%'
	and 
	(p_size = 10 or p_size = 20 or p_size = 30 or p_size = 40);