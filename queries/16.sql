-- QUERY 16
/*
+----+--------------------+----------+-----------------+---------------+---------+---------+---------------------+--------+----------------------------------------------+
| id | select_type        | table    | type            | possible_keys | key     | key_len | ref                 | rows   | Extra                                        |
+----+--------------------+----------+-----------------+---------------+---------+---------+---------------------+--------+----------------------------------------------+
|  1 | PRIMARY            | part     | ALL             | PRIMARY       | NULL    | NULL    | NULL                | 200000 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY            | partsupp | eq_ref          | PRIMARY       | PRIMARY | 4       | tpch.part.P_PARTKEY |      1 | Using where                                  |
|  2 | DEPENDENT SUBQUERY | supplier | unique_subquery | PRIMARY       | PRIMARY | 4       | func                |      1 | Using where                                  |
+----+--------------------+----------+-----------------+---------------+---------+---------+---------------------+--------+----------------------------------------------+
18312 rows in set (3.02 sec)
*/

explain(
SELECT
	p_brand,
	p_type,
	p_size,
	SUM(distinct supplier_cnt) AS supplier_cnt
FROM
	mv_16
WHERE
	p_brand <> 'Brand#45'
	AND p_type not like 'MEDIUM POLISHED%'
	AND p_size in (49, 14, 23, 45, 19, 3, 36, 9)
	AND ps_suppkey not in (
		SELECT
			s_suppkey
		FROM
			supplier
		WHERE
			s_comment like '%Customer%Complaints%'
	)
GROUP BY
	p_brand,
	p_type,
	p_size
ORDER BY
	supplier_cnt DESC,
	p_brand,
	p_type,
	p_size);

/*
+----+--------------------+----------+-----------------+---------------+---------+---------+------+--------+----------------------------------------------+
| id | select_type        | table    | type            | possible_keys | key     | key_len | ref  | rows   | Extra                                        |
+----+--------------------+----------+-----------------+---------------+---------+---------+------+--------+----------------------------------------------+
|  1 | PRIMARY            | mv_16    | ALL             | NULL          | NULL    | NULL    | NULL | 199993 | Using where; Using temporary; Using filesort |
|  2 | DEPENDENT SUBQUERY | supplier | unique_subquery | PRIMARY       | PRIMARY | 4       | func |      1 | Using where                                  |
+----+--------------------+----------+-----------------+---------------+---------+---------+------+--------+----------------------------------------------+
18312 rows in set (2.00 sec)
*/