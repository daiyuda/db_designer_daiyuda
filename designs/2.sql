-- QUERY 2
/*
select
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
from
	part,
	supplier,
	partsupp,
	nation,
	region
where
	p_partkey = ps_partkey
	and s_suppkey = ps_suppkey
	and p_size = 15
	and p_type like '%BRASS'
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'EUROPE'
	and ps_supplycost = (
		select
			min(ps_supplycost)
		from
			partsupp,
			supplier,
			nation,
			region
		where
			p_partkey = ps_partkey
			and s_suppkey = ps_suppkey
			and s_nationkey = n_nationkey
			and n_regionkey = r_regionkey
			and r_name = 'EUROPE'
	)
order by
	s_acctbal desc,
	n_name,
	s_name,
*/
/*
DROP TABLE IF EXISTS mv_supplycost;

CREATE TABLE mv_supplycost
	SELECT 
		ps_suppkey,
		MIN(ps_supplycost) AS supplycost,
		r_name
	FROM 
		partsupp,
		supplier,
		nation,
		region
	WHERE
		s_suppkey = ps_suppkey
		AND s_nationkey = n_nationkey
		AND n_regionkey = r_regionkey
	GROUP BY
		r_name;
*/
/*
DROP INDEX min_supply ON partsupp;
CREATE INDEX min_supply ON partsupp( ps_supplycost );
*/
DROP INDEX size ON part;
CREATE INDEX size ON part( p_size );

DROP INDEX name ON region;
CREATE INDEX name ON region( r_name );

DROP INDEX regionkey ON nation;
CREATE INDEX regionkey ON nation( n_regionkey );
