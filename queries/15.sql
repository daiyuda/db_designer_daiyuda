-- QUERY 15

/*
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
| id | select_type | table      | type   | possible_keys | key     | key_len | ref                  | rows    | Extra                                        |
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
|  1 | PRIMARY     | <derived3> | ALL    | NULL          | NULL    | NULL    | NULL                 |    9968 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY     | supplier   | eq_ref | PRIMARY       | PRIMARY | 4       | revenue0.supplier_no |       1 |                                              |
|  3 | DERIVED     | lineitem   | ALL    | NULL          | NULL    | NULL    | NULL                 | 1500000 | Using where; Using temporary; Using filesort |
|  2 | SUBQUERY    | <derived4> | ALL    | NULL          | NULL    | NULL    | NULL                 |    9968 |                                              |
|  4 | DERIVED     | lineitem   | ALL    | NULL          | NULL    | NULL    | NULL                 | 1500000 | Using where; Using temporary; Using filesort |
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
1 row in set (6.75 sec)
*/

DROP VIEW IF EXISTS revenue0;

CREATE VIEW revenue0 (supplier_no, total_revenue) AS
	SELECT
		l_suppkey,
		SUM(price)
	FROM
		mv_15
	WHERE
		l_shipdate >= date '1996-01-01'
		AND l_shipdate < date '1996-01-01' + interval '3' month
	GROUP BY
		l_suppkey;



SELECT
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
FROM
	supplier,
	revenue0
WHERE
	s_suppkey = supplier_no
	AND total_revenue = (
		SELECT
			MAX(total_revenue)
		FROM
			revenue0
	)
ORDER BY
	s_suppkey;

DROP VIEW revenue0;

/*
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
| id | select_type | table      | type   | possible_keys | key     | key_len | ref                  | rows    | Extra                                        |
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
|  1 | PRIMARY     | <derived3> | ALL    | NULL          | NULL    | NULL    | NULL                 |    9968 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY     | supplier   | eq_ref | PRIMARY       | PRIMARY | 4       | revenue0.supplier_no |       1 |                                              |
|  3 | DERIVED     | mv_15      | ALL    | NULL          | NULL    | NULL    | NULL                 | 1454720 | Using where; Using temporary; Using filesort |
|  2 | SUBQUERY    | <derived4> | ALL    | NULL          | NULL    | NULL    | NULL                 |    9968 |                                              |
|  4 | DERIVED     | mv_15      | ALL    | NULL          | NULL    | NULL    | NULL                 | 1454720 | Using where; Using temporary; Using filesort |
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
1 row in set (2.29 sec)
*/
