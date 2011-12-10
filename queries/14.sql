-- QUERY 14
/*
+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                     | rows    | Extra       |
+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
|  1 | SIMPLE      | lineitem | ALL    | NULL          | NULL    | NULL    | NULL                    | 1500000 | Using where |
|  1 | SIMPLE      | part     | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_PARTKEY |       1 |             |
+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
1 row in set (4.09 sec)
*/

SELECT
	100.00 * SUM(CASE
		WHEN p_type LIKE 'PROMO%'
			THEN price
		ELSE 0
	END) / SUM(price) AS promo_revenue
FROM
	mv_14
WHERE
	l_shipdate >= date '1995-09-01'
	AND l_shipdate < date '1995-09-01' + interval '1' month;

/*
+----+-------------+-------+------+---------------+------+---------+------+---------+-------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows    | Extra       |
+----+-------------+-------+------+---------------+------+---------+------+---------+-------------+
|  1 | SIMPLE      | mv_14 | ALL  | NULL          | NULL | NULL    | NULL | 1500000 | Using where |
+----+-------------+-------+------+---------------+------+---------+------+---------+-------------+
1 row in set (1.79 sec)
*/