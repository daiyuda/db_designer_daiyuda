-- QUERY 18

+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                     | rows    | Extra       |
+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
|  1 | SIMPLE      | lineitem | ALL    | NULL          | NULL    | NULL    | NULL                    | 1500000 | Using where |
|  1 | SIMPLE      | part     | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_PARTKEY |       1 | Using where |
+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
1 row in set (5.91 sec)


SELECT
	SUM(revenue) AS revenue
FROM
	mv_18
WHERE
	(
		p_brand = 'Brand#12'
		AND p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		AND l_quantity >= 1 AND l_quantity <= 1 + 10
		AND p_size between 1 AND 5
		AND l_shipinstruct = 'DELIVER IN PERSON'
		AND l_shipmode in ('AIR', 'AIR REG')
	)
	OR
	(
		p_brand = 'Brand#23'
		AND p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		AND l_quantity >= 10 AND l_quantity <= 10 + 10
		AND p_size between 1 AND 10
		AND l_shipinstruct = 'DELIVER IN PERSON'
		AND l_shipmode in ('AIR', 'AIR REG')
	)
	OR
	(
		p_brand = 'Brand#34'
		AND p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		AND l_quantity >= 20 AND l_quantity <= 20 + 10
		AND p_size between 1 AND 15
		AND l_shipinstruct = 'DELIVER IN PERSON'
		AND l_shipmode in ('AIR', 'AIR REG')
	);


+----+-------------+-------+------+---------------+------+---------+------+---------+-------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows    | Extra       |
+----+-------------+-------+------+---------------+------+---------+------+---------+-------------+
|  1 | SIMPLE      | mv_18 | ALL  | NULL          | NULL | NULL    | NULL | 1476993 | Using where |
+----+-------------+-------+------+---------------+------+---------+------+---------+-------------+
1 row in set (2.67 sec)
