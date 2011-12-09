-- QUERY 10

DROP TABLE IF EXISTS mv_10;
CREATE TABLE mv_10
	SELECT
		c_custkey,
		c_name,
		SUM(l_extendedprice * (1 - l_discount)) AS revenue,
		c_acctbal,
		n_name,
		c_address,
		c_phone,
		c_comment,
		o_orderdate,
		l_returnflag
	FROM
		customer,
		orders,
		lineitem,
		nation
	WHERE
		c_custkey = o_custkey
		AND l_orderkey = o_orderkey
		AND c_nationkey = n_nationkey
	GROUP BY
		c_custkey,
		c_name,
		c_acctbal,
		c_phone,
		n_name,
		c_address,
		c_comment,
		o_orderdate,
		l_returnflag;

DROP INDEX orderdate ON mv10;
CREATE INDEX orderdate ON mv10 (o_orderdate);