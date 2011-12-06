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
	p_partkey;
*/
DROP TABLE mv_supplycost IF EXISTS;

CREATE TABLE mv_supplycost
	SELECT 
		s_acctbal,
		s_name,
		n_name,
		p_partkey,
		p_mfgr,
		s_address,
		s_phone,
		s_comment,
		ps_supplycost,
		p_size,
		p_type,
		r_name
	FROM 
		part,
		partsupp,
		supplier,
		nation,
		region
	WHERE
		p_partkey = ps_partkey
		AND s_suppkey = ps_suppkey
		AND s_nationkey = n_nationkey
		AND n_regionkey = r_regionkey;
