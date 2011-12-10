-- QUERY 6

+----+-------------+----------+------+---------------+------+---------+------+---------+-------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows    | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+---------+-------------+
|  1 | SIMPLE      | lineitem | ALL  | NULL          | NULL | NULL    | NULL | 1500000 | Using where |
+----+-------------+----------+------+---------------+------+---------+------+---------+-------------+
1 row in set (3.57 sec)

SELECT
	SUM(revenue) AS revenue
FROM
	mv_6
WHERE
	l_shipdate >= date '1994-01-01'
	AND l_shipdate < date '1994-01-01' + interval '1' year
	AND l_discount between .06 - 0.01 AND .06 + 0.01
	AND l_quantity < 24;

+----+-------------+-------+------+---------------+------+---------+------+--------+-------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows   | Extra       |
+----+-------------+-------+------+---------------+------+---------+------+--------+-------------+
|  1 | SIMPLE      | mv_6  | ALL  | NULL          | NULL | NULL    | NULL | 905420 | Using where |
+----+-------------+-------+------+---------------+------+---------+------+--------+-------------+
1 row in set (0.88 sec)
