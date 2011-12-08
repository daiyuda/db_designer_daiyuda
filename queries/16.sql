-- QUERY 16
/*
+----+--------------------+----------+-----------------+---------------+---------+---------+---------------------+-------+----------------------------------------------+
| id | select_type        | table    | type            | possible_keys | key     | key_len | ref                 | rows  | Extra                                        |
+----+--------------------+----------+-----------------+---------------+---------+---------+---------------------+-------+----------------------------------------------+
|  1 | PRIMARY            | part     | range           | PRIMARY,size  | size    | 4       | NULL                | 30954 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY            | partsupp | eq_ref          | PRIMARY       | PRIMARY | 4       | tpch.part.P_PARTKEY |     1 | Using where                                  |
|  2 | DEPENDENT SUBQUERY | supplier | unique_subquery | PRIMARY       | PRIMARY | 4       | func                |     1 | Using where                                  |
+----+--------------------+----------+-----------------+---------------+---------+---------+---------------------+-------+----------------------------------------------+
*/
/*
explain(
select
	p_brand,
	p_type,
	p_size,
	count(distinct ps_suppkey) as supplier_cnt
from
	partsupp,
	part
where
	p_partkey = ps_partkey
	and p_brand <> 'Brand#45'
	and p_type not like 'MEDIUM POLISHED%'
	and p_size in (49, 14, 23, 45, 19, 3, 36, 9)
	and ps_suppkey not in (
		select
			s_suppkey
		from
			supplier
		where
			s_comment like '%Customer%Complaints%'
	)
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size
);
*/
/*
select
	p_brand,
	p_type,
	p_size,
	count(distinct ps_suppkey) as supplier_cnt
from
	partsupp,
	part
where
	p_partkey = ps_partkey
	and p_brand <> 'Brand#45'
	and p_type not like 'MEDIUM POLISHED%'
	and p_size in (49, 14, 23, 45, 19, 3, 36, 9)
	and ps_suppkey not in (
		select
			s_suppkey
		from
			supplier
		where
			s_comment like '%Customer%Complaints%'
	)
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size;
*/
