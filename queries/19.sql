-- QUERY 19

+----+--------------------+----------+--------+-------------------+---------+---------+------------------------+---------+----------------------------------------------+
| id | select_type        | table    | type   | possible_keys     | key     | key_len | ref                    | rows    | Extra                                        |
+----+--------------------+----------+--------+-------------------+---------+---------+------------------------+---------+----------------------------------------------+
|  1 | PRIMARY            | nation   | ref    | PRIMARY,name      | name    | 25      | const                  |       1 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY            | orders   | ALL    | PRIMARY           | NULL    | NULL    | NULL                   | 1500000 | Using where; Using join buffer               |
|  1 | PRIMARY            | l1       | eq_ref | PRIMARY           | PRIMARY | 4       | tpch.orders.O_ORDERKEY |       1 | Using where                                  |
|  1 | PRIMARY            | supplier | eq_ref | PRIMARY,nationkey | PRIMARY | 4       | tpch.l1.L_SUPPKEY      |       1 | Using where                                  |
|  3 | DEPENDENT SUBQUERY | l3       | eq_ref | PRIMARY           | PRIMARY | 4       | tpch.l1.L_ORDERKEY     |       1 | Using where                                  |
|  2 | DEPENDENT SUBQUERY | l2       | eq_ref | PRIMARY           | PRIMARY | 4       | tpch.l1.L_ORDERKEY     |       1 | Using where                                  |
+----+--------------------+----------+--------+-------------------+---------+---------+------------------------+---------+----------------------------------------------+
Empty set (49.81 sec)


SELECT 
	s_name,
	SUM(numwait) AS numwait
FROM
	mv_19
WHERE
	o_orderstatus = 'F'
	AND n_name = 'SAUDI ARABIA'
GROUP BY
	s_name
ORDER BY
	numwait DESC,
	s_name;

+----+-------------+-------+------+---------------+------+---------+------+------+-----------------------------------------------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows | Extra                                               |
+----+-------------+-------+------+---------------+------+---------+------+------+-----------------------------------------------------+
|  1 | SIMPLE      | NULL  | NULL | NULL          | NULL | NULL    | NULL | NULL | Impossible WHERE noticed after reading const tables |
+----+-------------+-------+------+---------------+------+---------+------+------+-----------------------------------------------------+
Empty set (0.00 sec)
