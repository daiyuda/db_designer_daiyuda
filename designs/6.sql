-- QUERY 6

DROP TABLE IF EXISTS mv_6;
CREATE TABLE mv_6 
	SELECT 
		SUM(l_extendedprice * l_discount) AS revenue,
		l_shipdate,
		l_discount,
		l_quantity
	FROM
		lineitem
	GROUP BY
		l_shipdate,
		l_discount,
		l_quantity;
/*
DROP INDEX shipdate ON mv_6;
CREATE INDEX shipdate ON mv_6 (l_shipdate);
*/