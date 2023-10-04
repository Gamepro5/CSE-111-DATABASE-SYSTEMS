.headers on
select part_type, min(discount) as min_disc, max(discount) as max_disc
from (select p_type as part_type, l_discount as discount
		from part, lineitem
		where p_partkey = l_partkey and (p_type like '%ECONOMY%' or p_type like '%COPPER%')	
		)
group by part_type;