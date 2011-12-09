-- QUERY 16

DROP TABLE IF EXISTS mv_16;
CREATE TABLE mv_16
	SELECT
		p_brand,
		p_type,
		p_size,
		COUNT(DISTINCT ps_suppkey) AS supplier_cnt,
		ps_suppkey
	FROM
		partsupp,
		part
	WHERE
		p_partkey = ps_partkey
	GROUP BY
		p_brand,
		p_type,
		p_size,
		ps_suppkey;

/*
DROP INDEX size ON mv_16;
CREATE INDEX size ON mv_16 (p_size);
*/