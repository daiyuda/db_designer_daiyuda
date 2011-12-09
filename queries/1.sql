-- QUERY 1
/*
+----+-------------+----------+------+---------------+------+---------+------+---------+----------------------------------------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows    | Extra                                        |
+----+-------------+----------+------+---------------+------+---------+------+---------+----------------------------------------------+
|  1 | SIMPLE      | lineitem | ALL  | NULL          | NULL | NULL    | NULL | 1500000 | Using where; Using temporary; Using filesort |
+----+-------------+----------+------+---------------+------+---------+------+---------+----------------------------------------------+
4 rows in set (19.78 sec)
*/
EXPLAIN(
	SELECT
		l_returnflag,
		l_linestatus,
		SUM(sum_qty) AS sum_qty,
		SUM(sum_base_price) AS sum_base_price,
		SUM(sum_disc_price) AS sum_disc_price,
		SUM(sum_charge) AS sum_charge,
		
		SUM(sum_qty) / SUM(count_order) AS avg_qty,
		SUM(sum_base_price) / SUM(count_order) AS avg_price,
		SUM(sum_discount) / SUM(count_order) AS avg_disc,
	
		SUM(count_order) AS count_order
	FROM
		mv_1
	WHERE
		l_shipdate <= date '1998-12-01'
	GROUP BY
		l_returnflag,
		l_linestatus
	ORDER BY
		l_returnflag,
		l_linestatus
);

SELECT
	l_returnflag,
	l_linestatus,
	SUM(sum_qty) AS sum_qty,
	SUM(sum_base_price) AS sum_base_price,
	SUM(sum_disc_price) AS sum_disc_price,
	SUM(sum_charge) AS sum_charge,
	
	SUM(sum_qty) / SUM(count_order) AS avg_qty,
	SUM(sum_base_price) / SUM(count_order) AS avg_price,
	SUM(sum_discount) / SUM(count_order) AS avg_disc,

	SUM(count_order) AS count_order
FROM
	mv_1
WHERE
	l_shipdate <= date '1998-12-01'
GROUP BY
	l_returnflag,
	l_linestatus
ORDER BY
	l_returnflag,
	l_linestatus;