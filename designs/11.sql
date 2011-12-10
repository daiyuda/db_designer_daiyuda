-- QUERY 11


DROP TABLE IF EXISTS mv_11;
CREATE TABLE mv_11
	SELECT
		ps_partkey,
		SUM(ps_supplycost * ps_availqty) AS total,
		n_name
	FROM
		partsupp,
		supplier,
		nation
	WHERE
		ps_suppkey = s_suppkey
		AND s_nationkey = n_nationkey
	GROUP BY
		ps_partkey,
		n_name;

DROP INDEX name ON mv_11;
CREATE INDEX name ON mv_11( n_name );

/*
DROP INDEX suppkey ON partsupp;
CREATE INDEX suppkey ON partsupp(ps_suppkey);

DROP INDEX nationkey ON supplier;
CREATE INDEX nationkey ON supplier(s_nationkey);

DROP INDEX name ON nation;
CREATE INDEX name ON nation( n_name );
*/