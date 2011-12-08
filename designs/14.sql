-- QUERY 14
/*
select
	100.00 * sum(case
		when p_type like 'PROMO%'
			then l_extendedprice * (1 - l_discount)
		else 0
	end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from
	lineitem,
	part
where
	l_partkey = p_partkey
	and l_shipdate >= date '1995-09-01'
	and l_shipdate < date '1995-09-01' + interval '1' month;
*/
/*
drop index shipdate on lineitem;
create index shipdate on lineitem(l_shipdate);
*/

DROP TABLE IF EXISTS mv_14;
CREATE TABLE mv_14
	SELECT
		p_type,
		l_extendedprice * (1 - l_discount) AS price,
		SUM(l_extendedprice * (1 - l_discount)) AS total,
		l_shipdate
	FROM
		lineitem,
		part
	WHERE
		l_partkey = p_partkey
	GROUP BY
		p_type,
		price,
		l_shipdate;
	