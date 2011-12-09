-- QUERY 8

DROP TABLE IF EXISTS mv_8;
CREATE TABLE mv_8
	SELECT
		extract(year FROM o_orderdate) AS o_year,
		SUM(l_extendedprice * (1 - l_discount)) AS volume,
		n2.n_name AS nation,
		r_name,
		o_orderdate,
		p_type
	FROM
		part,
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2,
		region
	WHERE
		p_partkey = l_partkey
		AND s_suppkey = l_suppkey
		AND l_orderkey = o_orderkey
		AND o_custkey = c_custkey
		AND c_nationkey = n1.n_nationkey
		AND n1.n_regionkey = r_regionkey
		AND s_nationkey = n2.n_nationkey
	GROUP BY
		o_year,
		nation,
		r_name,
		o_orderdate,
		p_type;

DROP INDEX name ON mv_8;
CREATE INDEX name ON mv_8 ( r_name );

DROP INDEX p_type ON mv_8;
CREATE INDEX p_type ON mv_8 ( p_type );
