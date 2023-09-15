.headers on
select sum(c_acctbal) as tot_acct_bal
from customer, nation, region
where c_mktsegment = "FURNITURE" and c_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name == "AMERICA"