.headers on
select s_name as supplier, count(p_partkey) as cnt
from supplier, nation, partsupp, part
where s_nationkey = n_nationkey and ps_suppkey = s_suppkey and p_partkey = ps_partkey and n_name = "KENYA" and INSTR(p_container, "BOX")
group by s_name;