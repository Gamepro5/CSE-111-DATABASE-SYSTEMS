.headers on
select s_name as supplier, p_size as part_size, max(ps_supplycost) /*at maximum cost*/ as max_cost
from supplier, part, partsupp, nation
where 
	p_type like '%STEEL%' /*parts that contain steel*/
	and
	p_partkey = ps_partkey
	and
	ps_suppkey = s_suppkey
	and
	s_nationkey = n_nationkey and n_regionkey = 1 /*and from american suppliers*/
group by p_size /*for each size*/;