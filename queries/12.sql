-- QUERY 12

+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+---------------------------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                    | rows    | Extra                           |
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+---------------------------------+
|  1 | SIMPLE      | orders   | ALL    | PRIMARY       | NULL    | NULL    | NULL                   | 1500000 | Using temporary; Using filesort |
|  1 | SIMPLE      | lineitem | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY |       1 | Using where                     |
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+---------------------------------+
2 rows in set (59.56 sec)



SELECT
	l_shipmode,
	SUM(CASE
		WHEN o_orderpriority = '1-URGENT'
			OR o_orderpriority = '2-HIGH'
			THEN total
		ELSE 0
	END) AS high_line_count,
	SUM(CASE
		WHEN o_orderpriority <> '1-URGENT'
			AND o_orderpriority <> '2-HIGH'
			THEN total
		ELSE 0
	END) AS low_line_count
FROM
	mv_12
WHERE
	l_shipmode IN ('MAIL', 'SHIP')
	AND l_receiptdate >= date '1994-01-01'
	AND l_receiptdate < date '1994-01-01' + interval '1' year
GROUP BY
	l_shipmode
ORDER BY
	l_shipmode;


+----+-------------+-------+------+---------------+------+---------+------+-------+----------------------------------------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows  | Extra                                        |
+----+-------------+-------+------+---------------+------+---------+------+-------+----------------------------------------------+
|  1 | SIMPLE      | mv_12 | ALL  | NULL          | NULL | NULL    | NULL | 74727 | Using where; Using temporary; Using filesort |
+----+-------------+-------+------+---------------+------+---------+------+-------+----------------------------------------------+
2 rows in set (0.07 sec)
