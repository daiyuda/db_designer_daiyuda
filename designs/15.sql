-- QUERY 15

DROP TABLE IF EXISTS mv_15;
CREATE TABLE mv_15
	SELECT
		l_suppkey,
		l_extendedprice * (1 - l_discount) AS price,
		l_shipdate
	FROM
		lineitem
	GROUP BY
		l_suppkey,
		l_shipdate;

