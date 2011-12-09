-- QUERY 14

DROP TABLE IF EXISTS mv_14;
CREATE TABLE mv_14
	SELECT
		p_type,
		l_extendedprice * (1 - l_discount) AS price,
		l_shipdate
	FROM
		lineitem,
		part
	WHERE
		l_partkey = p_partkey;

DROP INDEX shipdate ON mv_14;
CREATE INDEX shipdate ON mv_14 (l_shipdate);
	