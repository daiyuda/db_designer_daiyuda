-- QUERY 3
/*
select
	l_orderkey,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	o_orderdate,
	o_shippriority
from
	customer,
	orders,
	lineitem
where
	c_mktsegment = 'BUILDING'
	and c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate < date '1995-03-15'
	and l_shipdate > date '1995-03-15'
group by
	l_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate;
*/
DROP TABLE IF EXISTS mv_col;
CREATE TABLE mv_col 
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