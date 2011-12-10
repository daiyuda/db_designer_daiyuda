-- QUERY 4

+----+--------------------+----------+--------+---------------+---------+---------+------------------------+---------+----------------------------------------------+
| id | select_type        | table    | type   | possible_keys | key     | key_len | ref                    | rows    | Extra                                        |
+----+--------------------+----------+--------+---------------+---------+---------+------------------------+---------+----------------------------------------------+
|  1 | PRIMARY            | orders   | ALL    | NULL          | NULL    | NULL    | NULL                   | 1500000 | Using where; Using temporary; Using filesort |
|  2 | DEPENDENT SUBQUERY | lineitem | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY |       1 | Using where                                  |
+----+--------------------+----------+--------+---------------+---------+---------+------------------------+---------+----------------------------------------------+
5 rows in set (5.64 sec)



SELECT
	o_orderpriority,
	SUM(order_count) AS order_count
FROM
	mv_4
WHERE
	o_orderdate >= date '1993-07-01'
	AND o_orderdate < date '1993-07-01' + interval '3' month
GROUP BY
	o_orderpriority
ORDER BY
	o_orderpriority;


+----+-------------+-------+------+---------------+------+---------+------+-------+----------------------------------------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows  | Extra                                        |
+----+-------------+-------+------+---------------+------+---------+------+-------+----------------------------------------------+
|  1 | SIMPLE      | mv_4  | ALL  | NULL          | NULL | NULL    | NULL | 12030 | Using where; Using temporary; Using filesort |
+----+-------------+-------+------+---------------+------+---------+------+-------+----------------------------------------------+
5 rows in set (0.01 sec)
