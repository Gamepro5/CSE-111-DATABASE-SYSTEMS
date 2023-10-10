.headers on
select r_name as "region", count(s_suppkey) as supp_cnt
from supplier, region r, nation
where 	s_nationkey = n_nationkey and n_regionkey = r.r_regionkey 
		and
		s_acctbal > (select avg(s_acctbal)
					from supplier, nation, region
					where s_nationkey = n_nationkey 
					and 
					n_regionkey = r.r_regionkey /* r is so we are talking about the same region */
					group by r_name)
group by r_name;