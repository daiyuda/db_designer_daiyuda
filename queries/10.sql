-- QUERY 10

+----+-------------+----------+--------+---------------+---------+---------+---------------------------+---------+----------------------------------------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                       | rows    | Extra                                        |
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+---------+----------------------------------------------+
|  1 | SIMPLE      | orders   | ALL    | PRIMARY       | NULL    | NULL    | NULL                      | 1500000 | Using where; Using temporary; Using filesort |
|  1 | SIMPLE      | customer | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_CUSTKEY     |       1 |                                              |
|  1 | SIMPLE      | nation   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.customer.C_NATIONKEY |       1 |                                              |
|  1 | SIMPLE      | lineitem | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY    |       1 | Using where                                  |
+----+-------------+----------+--------+---------------+---------+---------+---------------------------+---------+----------------------------------------------+
24470 rows in set (10.33 sec)


SELECT
	c_custkey,
	c_name,
	SUM(revenue) AS revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
FROM
	mv_10
WHERE
	o_orderdate >= date '1993-10-01'
	AND o_orderdate < date '1993-10-01' + interval '3' month
	AND l_returnflag = 'R'
GROUP BY
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
ORDER BY
	revenue DESC;


+----+-------------+-------+-------+---------------+-----------+---------+------+-------+----------------------------------------------+
| id | select_type | table | type  | possible_keys | key       | key_len | ref  | rows  | Extra                                        |
+----+-------------+-------+-------+---------------+-----------+---------+------+-------+----------------------------------------------+
|  1 | SIMPLE      | mv_10 | range | orderdate     | orderdate | 3       | NULL | 48516 | Using where; Using temporary; Using filesort |
+----+-------------+-------+-------+---------------+-----------+---------+------+-------+----------------------------------------------+
24470 rows in set (2.00 sec)
