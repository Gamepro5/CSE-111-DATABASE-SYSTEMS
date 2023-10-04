.headers on
select n_name as country, count(s_suppkey) as cnt
from supplier, nation
where s_nationkey = n_nationkey and (n_name = "ARGENTINA" or n_name = "BRAZIL")
group by n_name;