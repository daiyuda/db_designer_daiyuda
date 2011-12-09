-- QUERY 19

DROP TABLE IF EXISTS mv_19;
CREATE TABLE mv_19
	SELECT
		s_name,
		COUNT(*) AS numwait,
		o_orderstatus,
		n_name
	FROM
		supplier,
		lineitem l1,
		orders,
		nation
	WHERE
		s_suppkey = l1.l_suppkey
		AND o_orderkey = l1.l_orderkey
		AND l1.l_receiptdate > l1.l_commitdate
		AND exists (
			SELECT
				*
			FROM
				lineitem l2
			WHERE
				l2.l_orderkey = l1.l_orderkey
				AND l2.l_suppkey <> l1.l_suppkey
		)
		AND NOT EXISTS (
			SELECT
				*
			FROM
				lineitem l3
			WHERE
				l3.l_orderkey = l1.l_orderkey
				AND l3.l_suppkey <> l1.l_suppkey
				AND l3.l_receiptdate > l3.l_commitdate
		)
		AND s_nationkey = n_nationkey
	GROUP BY
		s_name,
		o_orderstatus,
		n_name;