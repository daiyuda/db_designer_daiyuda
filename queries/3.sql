-- QUERY 3
/*

*/
EXPLAIN(
	SELECT
		l_orderkey,
		revenue,
		o_orderdate,
		o_shippriority
	FROM
		mv_3
	WHERE
		c_mktsegment = 'BUILDING'
		AND o_orderdate < date '1995-03-15'
		AND l_shipdate > date '1995-03-15'
);

SELECT
	l_orderkey,
	revenue,
	o_orderdate,
	o_shippriority
FROM
	mv_3
WHERE
	c_mktsegment = 'BUILDING'
	AND o_orderdate < date '1995-03-15'
	AND l_shipdate > date '1995-03-15';
