-- QUERY 9
/*
+----+-------------+------------+--------+---------------+---------+---------+---------------------------+---------+---------------------------------+
| id | select_type | table      | type   | possible_keys | key     | key_len | ref                       | rows    | Extra                           |
+----+-------------+------------+--------+---------------+---------+---------+---------------------------+---------+---------------------------------+
|  1 | PRIMARY     | <derived2> | ALL    | NULL          | NULL    | NULL    | NULL                      |   19792 | Using temporary; Using filesort |
|  2 | DERIVED     | orders     | ALL    | PRIMARY       | NULL    | NULL    | NULL                      | 1500000 |                                 |
|  2 | DERIVED     | lineitem   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY    |       1 |                                 |
|  2 | DERIVED     | part       | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_PARTKEY   |       1 | Using where                     |
|  2 | DERIVED     | partsupp   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_PARTKEY   |       1 | Using where                     |
|  2 | DERIVED     | supplier   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_SUPPKEY   |       1 |                                 |
|  2 | DERIVED     | nation     | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.supplier.S_NATIONKEY |       1 |                                 |
+----+-------------+------------+--------+---------------+---------+---------+---------------------------+---------+---------------------------------+
*/


SELECT
	nation,
	o_year,
	SUM(amount) AS sum_profit
FROM
	mv_9
WHERE
	p_name like '%green%'
GROUP BY
	nation,
	o_year
ORDER BY
	nation,
	o_year DESC;

EXPLAIN(
	SELECT
		nation,
		o_year,
		SUM(amount) AS sum_profit
	FROM
		mv_9
	WHERE
		p_name like '%green%'
	GROUP BY
		nation,
		o_year
	ORDER BY
		nation,
		o_year DESC
);