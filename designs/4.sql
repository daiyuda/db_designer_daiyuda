-- QUERY 4

DROP TABLE IF EXISTS mv_4;
CREATE TABLE mv_4
	SELECT
		o_orderpriority,
		COUNT(*) AS order_count,
		o_orderdate
	FROM
		orders
	WHERE
		EXISTS (
			SELECT
				*
			FROM
				lineitem
			WHERE
				l_orderkey = o_orderkey
				AND l_commitdate < l_receiptdate
		)
	GROUP BY
		o_orderpriority,
		o_orderdate;
