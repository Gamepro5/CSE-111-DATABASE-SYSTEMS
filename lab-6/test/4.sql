.headers on
select n_name as "country"
from nation, lineitem, supplier
where 
	strftime('%Y', l_shipdate) = '1994'
	and
	s_suppkey = l_suppkey
	and
	s_nationkey = n_nationkey
	and
	l_extendedprice = (
			select min(l_extendedprice)
			from lineitem, supplier, nation
			where 
				strftime('%Y', l_shipdate) = '1994' 
				and 
				s_suppkey = l_suppkey 
				and 
				s_nationkey = n_nationkey
				);