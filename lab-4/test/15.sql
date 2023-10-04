.headers on
select region, supplier, max(acct_bal)
from 	(select r_name as region, s_name as supplier, s_acctbal as acct_bal
		from region, supplier, nation
		where s_nationkey = n_nationkey and n_regionkey = r_regionkey
		group by s_name
		)
group by region;