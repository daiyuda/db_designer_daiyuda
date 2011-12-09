-- QUERY 3

DROP TABLE IF EXISTS mv_3;
CREATE TABLE mv_3 
	SELECT 
		l_orderkey,
		sum(l_extendedprice * (1 - l_discount)) as revenue,
		o_orderdate,
		o_shippriority,
		c_mktsegment,
		l_shipdate
	FROM
		customer,
		orders,
		lineitem
	WHERE
		c_custkey = o_custkey
		AND l_orderkey = o_orderkey
	GROUP BY
		l_orderkey,
		o_orderdate,
		o_shippriority,
		c_mktsegment,
		o_orderdate,
		l_shipdate
	ORDER BY
		revenue DESC,
		o_orderdate;

DROP INDEX mktsegment ON mv_3;
CREATE INDEX mktsegment ON mv_3 ( c_mktsegment );