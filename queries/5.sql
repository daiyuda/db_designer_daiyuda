-- QUERY 5

/*
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+---------+----------------------------------------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                       | rows    | Extra                                        |
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+---------+----------------------------------------------+
|  1 | SIMPLE      | orders   | ALL    | PRIMARY       | NULL    | NULL    | NULL                      | 1500000 | Using where; Using temporary; Using filesort |
|  1 | SIMPLE      | customer | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_CUSTKEY     |       1 |                                              |
|  1 | SIMPLE      | nation   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.customer.C_NATIONKEY |       1 |                                              |
|  1 | SIMPLE      | region   | ALL    | PRIMARY       | NULL    | NULL    | NULL                      |       5 | Using where; Using join buffer               |
|  1 | SIMPLE      | lineitem | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY    |       1 |                                              |
|  1 | SIMPLE      | supplier | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_SUPPKEY   |       1 | Using where                                  |
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+---------+----------------------------------------------+
5 rows in set (23.09 sec)
*/


SELECT
	n_name,
	SUM(revenue) AS revenue
FROM
	mv_5
WHERE
	r_name = 'ASIA'
	AND o_orderdate >= date '1994-01-01'
	AND o_orderdate < date '1994-01-01' + interval '1' year
GROUP BY
	n_name
ORDER BY
	revenue DESC;

EXPLAIN(
	SELECT
		n_name,
		SUM(revenue) AS revenue
	FROM
		mv_5
	WHERE
		r_name = 'ASIA'
		AND o_orderdate >= date '1994-01-01'
		AND o_orderdate < date '1994-01-01' + interval '1' year
	GROUP BY
		n_name
	ORDER BY
		revenue DESC
);
