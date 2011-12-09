-- QUERY 7

DROP TABLE IF EXISTS mv_7;
CREATE TABLE mv_7
	SELECT 
		n1.n_name AS supp_nation,
		n2.n_name AS cust_nation,
		extract(year FROM l_shipdate) AS l_year,
		SUM(l_extendedprice * (1 - l_discount)) AS volume,
		l_shipdate
	FROM
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2
	WHERE
		s_suppkey = l_suppkey
		AND o_orderkey = l_orderkey
		AND c_custkey = o_custkey
		AND s_nationkey = n1.n_nationkey
		AND c_nationkey = n2.n_nationkey
	GROUP BY
		supp_nation,	
		cust_nation,
		l_year,
		l_shipdate;

DROP INDEX supp_nation ON mv_7;
CREATE INDEX supp_nation ON mv_7 (supp_nation);

DROP INDEX cust_nation ON mv_7;
CREATE INDEX cust_nation ON mv_7 (cust_nation);
