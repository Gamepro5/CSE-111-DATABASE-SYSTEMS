.headers on
with suppliers_from_peru as (
select s_suppkey from supplier, nation where s_nationkey = n_nationkey and n_name = "PERU"
)

select count(distinct s_suppkey) as "suppliers_cnt"
from part, partsupp, suppliers_from_peru
where 
	s_suppkey = ps_suppkey
	and 
	ps_partkey = p_partkey 
	and 
	40 < (
			select count( p_partkey) 
			from part, partsupp 
			where 
				s_suppkey = ps_suppkey 
				and 
				ps_partkey = p_partkey
		);