-- QUERY 18

DROP TABLE IF EXISTS mv_18;
CREATE TABLE mv_18
	SELECT
		SUM(l_extendedprice* (1 - l_discount)) AS revenue,
		p_brand,
		p_container,
		l_quantity,
		p_size,
		l_shipmode,
		l_shipinstruct
	FROM
		lineitem,
		part
	WHERE
		p_partkey = l_partkey
	GROUP BY
		p_brand,
		p_container,
		l_quantity,
		p_size,
		l_shipmode,
		l_shipinstruct;
/*
DROP INDEX brand ON mv_18;
CREATE INDEX brand ON mv_18 ( p_brand );

DROP INDEX shipinstruct ON mv_18;
CREATE INDEX shipinstruct on mv_18 ( l_shipinstruct);
*/