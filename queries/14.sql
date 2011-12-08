-- QUERY 14
/*
explain(
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
	and l_shipdate < date '1995-09-01' + interval '1' month)
*/

EXPLAIN(
SELECT
	100.00 * SUM(CASE
		WHEN p_type LIKE 'PROMO%'
			THEN price
		ELSE 0
	END) / SUM(price) AS promo_revenue
FROM
	mv_14
WHERE
	l_shipdate >= date '1995-09-01'
	AND l_shipdate < date '1995-09-01' + interval '1' month;
);

SELECT
	100.00 * SUM(CASE
		WHEN p_type LIKE 'PROMO%'
			THEN price
		ELSE 0
	END) / SUM(price) AS promo_revenue
FROM
	mv_14
WHERE
	l_shipdate >= date '1995-09-01'
	AND l_shipdate < date '1995-09-01' + interval '1' month;