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

SELECT
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
FROM
	mv_supplycost
AS
	s1
WHERE
	s1.p_size = 15
	AND s1.p_type like '%BRASS'
	AND s1.r_name = 'EUROPE'
	and s1.ps_supplycost = (
		SELECT 
			MIN( ps_supplycost)
		FROM 
			mv_supplycost
		AS
			s2
		WHERE 
			s2.r_name = 'EUROPE'
	)
ORDER BY
	s1.s_acctbal DESC,
	s1.n_name,
	s1.s_name,
	s1.p_partkey;

