.headers on
with temptable as (select * from part, partsupp, supplier, nation
					where 
					p_partkey = ps_partkey and ps_suppkey = s_suppkey
					and
					s_nationkey = 6 /* supplier from france*/)


select p_name as "part"
from temptable
where
	(ps_supplycost*ps_availqty)>(select (ps_supplycost*ps_availqty) as total_value
									from temptable
									order by total_value
									limit 1 offset (
													select count(ps_supplycost*ps_availqty) as rows
													from temptable
													)*.95)

