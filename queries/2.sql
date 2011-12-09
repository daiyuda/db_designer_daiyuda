-- QUERY 2
/*
+----+--------------------+----------+--------+---------------+---------+---------+---------------------------+--------+----------------------------------------------+
| id | select_type        | table    | type   | possible_keys | key     | key_len | ref                       | rows   | Extra                                        |
+----+--------------------+----------+--------+---------------+---------+---------+---------------------------+--------+----------------------------------------------+
|  1 | PRIMARY            | part     | ALL    | PRIMARY       | NULL    | NULL    | NULL                      | 200000 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY            | partsupp | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.part.P_PARTKEY       |      1 | Using where                                  |
|  1 | PRIMARY            | supplier | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.partsupp.PS_SUPPKEY  |      1 |                                              |
|  1 | PRIMARY            | nation   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.supplier.S_NATIONKEY |      1 |                                              |
|  1 | PRIMARY            | region   | ALL    | PRIMARY       | NULL    | NULL    | NULL                      |      5 | Using where; Using join buffer               |
|  2 | DEPENDENT SUBQUERY | partsupp | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.part.P_PARTKEY       |      1 |                                              |
|  2 | DEPENDENT SUBQUERY | supplier | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.partsupp.PS_SUPPKEY  |      1 |                                              |
|  2 | DEPENDENT SUBQUERY | nation   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.supplier.S_NATIONKEY |      1 |                                              |
|  2 | DEPENDENT SUBQUERY | region   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.nation.N_REGIONKEY   |      1 | Using where                                  |
+----+--------------------+----------+--------+---------------+---------+---------+---------------------------+--------+----------------------------------------------+
162 rows in set (1.09 sec)
*/


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

EXPLAIN(
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
	p_partkey);

