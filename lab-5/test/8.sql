.headers on
select p_mfgr as manufacturer
from part, partsupp, 	(select s_suppkey, min(ps_availqty) as min_ps_availqty
						from supplier, partsupp
						where 	s_name = "Supplier#000000040" 
								and 
								s_suppkey = ps_suppkey
						)
where 	s_suppkey = ps_suppkey
		and 
		ps_partkey = p_partkey
		and 
		ps_availqty = min_ps_availqty;