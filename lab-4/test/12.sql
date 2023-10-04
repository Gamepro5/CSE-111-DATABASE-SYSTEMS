.headers on
select region, max_bal
from (select r_name as region, max(s_acctbal) as max_bal
		from supplier, nation, region
		where s_nationkey = n_nationkey and n_regionkey = r_regionkey
		group by r_name)
where max_bal > 9000;