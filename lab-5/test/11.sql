.headers on
select sum(ps_supplycost) as "total_supply_cost"
from supplier, partsupp, part, lineitem, (select l_suppkey as "valid_supplier" from lineitem where strftime('%Y', l_shipdate) = '1997' and l_extendedprice < 1000 group by l_suppkey)
where s_suppkey = ps_suppkey and ps_partkey = p_partkey and p_partkey = l_partkey and p_retailprice < 2000 and strftime('%Y', l_shipdate) = '1994'
	and valid_supplier = s_suppkey
