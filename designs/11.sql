-- QUERY 11


DROP TABLE IF EXISTS mv_11;
CREATE TABLE mv_11
	SELECT
		SUM(ps_supplycost * ps_availqty) * 0.0001000000 AS total,
		n_name
	FROM
		partsupp,
		supplier,
		nation
	WHERE
		ps_suppkey = s_suppkey
		AND s_nationkey = n_nationkey
	GROUP BY
		n_name;

DROP INDEX name ON mv_11;
CREATE INDEX name ON mv_11( n_name );

DROP INDEX suppkey ON partsupp;
CREATE INDEX suppkey ON partsupp(ps_suppkey);

DROP INDEX nationkey ON supplier;
CREATE INDEX nationkey ON supplier(s_nationkey);

DROP INDEX name ON nation;
CREATE INDEX name ON nation( n_name );