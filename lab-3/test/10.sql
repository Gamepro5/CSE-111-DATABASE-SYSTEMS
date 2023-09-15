.headers on
select s_name, s_acctbal
from supplier, region, nation
where s_nationkey == n_nationkey and n_regionkey == r_regionkey and r_name == "ASIA" and s_acctbal > 5000