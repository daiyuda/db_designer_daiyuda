-- QUERY 12

DROP TABLE IF EXISTS mv_12;
CREATE TABLE mv_12
	SELECT
		l_shipmode,
		o_orderpriority,
		COUNT(o_orderpriority) AS total,
		l_receiptdate
	FROM
		orders,
		lineitem
	WHERE
		o_orderkey = l_orderkey
		AND l_commitdate < l_receiptdate
		AND l_shipdate < l_commitdate
	GROUP BY
		l_shipmode,
		o_orderpriority,
		l_receiptdate;