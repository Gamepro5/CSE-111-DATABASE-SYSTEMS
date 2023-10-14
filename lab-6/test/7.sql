.headers on
select strftime('%m', l_shipdate) as "month", sum(l_quantity) as "tot_month"
from lineitem
where strftime('%Y', l_shipdate) = '1997'
group by strftime('%m', l_shipdate)