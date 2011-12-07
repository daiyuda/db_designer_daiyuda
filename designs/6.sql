-- QUERY 6
/*
select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1' year
	and l_discount between .06 - 0.01 and .06 + 0.01
	and l_quantity < 24;
*/

DROP TABLE IF EXISTS mv_6;
CREATE TABLE mv_6 
	SELECT 
		SUM(l_extendedprice * l_discount) AS revenue,
		l_shipdate,
		l_discount,
		l_quantity
	FROM
		lineitem
	GROUP BY
		l_shipdate,
		l_discount,
		l_quantity;

DROP INDEX shipdate ON mv_6;
CREATE INDEX shipdate ON mv_6 (l_shipdate);