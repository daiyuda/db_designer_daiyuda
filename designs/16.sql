-- QUERY 16

DROP TABLE IF EXISTS mv_16;
CREATE TABLE mv_16
	select
		p_brand,
		p_type,
		p_size,
		count(distinct ps_suppkey) as supplier_cnt,
		ps_suppkey
	from
		partsupp,
		part
	where
		p_partkey = ps_partkey
	group by
		p_brand,
		p_type,
		p_size,
		ps_suppkey;

/*
DROP INDEX size ON mv_16;
CREATE INDEX size ON mv_16 (p_size);
*/