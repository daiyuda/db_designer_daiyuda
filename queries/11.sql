-- QUERY 11
/*
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+--------+---------------------------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                       | rows   | Extra                           |
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+--------+---------------------------------+
|  1 | PRIMARY     | partsupp | ALL    | NULL          | NULL    | NULL    | NULL                      | 200000 | Using temporary; Using filesort |
|  1 | PRIMARY     | supplier | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.partsupp.PS_SUPPKEY  |      1 |                                 |
|  1 | PRIMARY     | nation   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.supplier.S_NATIONKEY |      1 | Using where                     |
|  2 | SUBQUERY    | partsupp | ALL    | NULL          | NULL    | NULL    | NULL                      | 200000 |                                 |
|  2 | SUBQUERY    | supplier | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.partsupp.PS_SUPPKEY  |      1 |                                 |
|  2 | SUBQUERY    | nation   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.supplier.S_NATIONKEY |      1 | Using where                     |
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+--------+---------------------------------+
3793 rows in set (25.96 sec)
*/

SELECT
	ps_partkey,
	SUM(ps_supplycost * ps_availqty) AS value
FROM
	partsupp,
	supplier,
	nation
WHERE
	ps_suppkey = s_suppkey
	AND s_nationkey = n_nationkey
	AND n_name = 'GERMANY'
GROUP BY
	ps_partkey HAVING
		SUM(ps_supplycost * ps_availqty) > (
			SELECT
				total
			FROM
				mv_11
			WHERE
				n_name = 'GERMANY'
		)
ORDER BY
	value DESC;

/*
+----+-------------+----------+------+-------------------+-----------+---------+-------------------------+------+----------------------------------------------+
| id | select_type | table    | type | possible_keys     | key       | key_len | ref                     | rows | Extra                                        |
+----+-------------+----------+------+-------------------+-----------+---------+-------------------------+------+----------------------------------------------+
|  1 | PRIMARY     | nation   | ref  | PRIMARY,name      | name      | 25      | const                   |    1 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY     | supplier | ref  | PRIMARY,nationkey | nationkey | 4       | tpch.nation.N_NATIONKEY |  400 |                                              |
|  1 | PRIMARY     | partsupp | ref  | suppkey           | suppkey   | 4       | tpch.supplier.S_SUPPKEY |   20 |                                              |
|  2 | SUBQUERY    | mv_11    | ref  | name              | name      | 25      | const                   |    1 | Using where                                  |
+----+-------------+----------+------+-------------------+-----------+---------+-------------------------+------+----------------------------------------------+
3793 rows in set (0.31 sec)
*/
