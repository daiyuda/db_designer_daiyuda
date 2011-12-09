-- QUERY 3
/*
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+----------------------------------------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                    | rows    | Extra                                        |
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+----------------------------------------------+
|  1 | SIMPLE      | orders   | ALL    | PRIMARY       | NULL    | NULL    | NULL                   | 1500000 | Using where; Using temporary; Using filesort |
|  1 | SIMPLE      | customer | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_CUSTKEY  |       1 | Using where                                  |
|  1 | SIMPLE      | lineitem | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY |       1 | Using where                                  |
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+----------------------------------------------+
7656 rows in set (38.79 sec)
*/

SELECT
	l_orderkey,
	revenue,
	o_orderdate,
	o_shippriority
FROM
	mv_3
WHERE
	c_mktsegment = 'BUILDING'
	AND o_orderdate < date '1995-03-15'
	AND l_shipdate > date '1995-03-15';

EXPLAIN(
	SELECT
		l_orderkey,
		revenue,
		o_orderdate,
		o_shippriority
	FROM
		mv_3
	WHERE
		c_mktsegment = 'BUILDING'
		AND o_orderdate < date '1995-03-15'
		AND l_shipdate > date '1995-03-15'
);
