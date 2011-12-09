-- QUERY 9

DROP TABLE IF EXISTS mv_9;
CREATE TABLE mv_9
	SELECT
		n_name AS nation,
		EXTRACT(YEAR FROM o_orderdate) AS o_year,
		SUM(l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity) AS amount,
		p_name
	FROM
		part,
		supplier,
		lineitem,
		partsupp,
		orders,
		nation
	WHERE
		s_suppkey = l_suppkey
		AND ps_suppkey = l_suppkey
		AND ps_partkey = l_partkey
		AND p_partkey = l_partkey
		AND o_orderkey = l_orderkey
		AND s_nationkey = n_nationkey
	GROUP BY
		nation,
		o_year,
		p_name;
