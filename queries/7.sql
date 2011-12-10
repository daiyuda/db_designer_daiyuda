-- QUERY 7

+----+-------------+------------+--------+------------------+---------+---------+---------------------------+---------+---------------------------------+
| id | select_type | table      | type   | possible_keys    | key     | key_len | ref                       | rows    | Extra                           |
+----+-------------+------------+--------+------------------+---------+---------+---------------------------+---------+---------------------------------+
|  1 | PRIMARY     | <derived2> | ALL    | NULL             | NULL    | NULL    | NULL                      |    1412 | Using temporary; Using filesort |
|  2 | DERIVED     | lineitem   | ALL    | PRIMARY,shipdate | NULL    | NULL    | NULL                      | 1500000 | Using where                     |
|  2 | DERIVED     | supplier   | eq_ref | PRIMARY          | PRIMARY | 4       | tpch.lineitem.L_SUPPKEY   |       1 |                                 |
|  2 | DERIVED     | n1         | eq_ref | PRIMARY          | PRIMARY | 4       | tpch.supplier.S_NATIONKEY |       1 | Using where                     |
|  2 | DERIVED     | orders     | eq_ref | PRIMARY          | PRIMARY | 4       | tpch.lineitem.L_ORDERKEY  |       1 |                                 |
|  2 | DERIVED     | customer   | eq_ref | PRIMARY          | PRIMARY | 4       | tpch.orders.O_CUSTKEY     |       1 |                                 |
|  2 | DERIVED     | n2         | eq_ref | PRIMARY          | PRIMARY | 4       | tpch.customer.C_NATIONKEY |       1 | Using where                     |
+----+-------------+------------+--------+------------------+---------+---------+---------------------------+---------+---------------------------------+
4 rows in set (1 min 50.82 sec)


SELECT
	supp_nation,
	cust_nation,
	l_year,
	SUM(volume) AS revenue
FROM 
	mv_7
WHERE
	((supp_nation = 'FRANCE' and cust_nation = 'GERMANY')
		OR (supp_nation = 'GERMANY' and cust_nation = 'FRANCE')	
	)
	AND l_shipdate between date '1995-01-01' and date '1996-12-31'
GROUP BY
	supp_nation,
	cust_nation,
	l_year
ORDER BY
	supp_nation,
	cust_nation,
	l_year;


+----+-------------+-------+-------+-------------------------+-------------+---------+------+-------+----------------------------------------------+
| id | select_type | table | type  | possible_keys           | key         | key_len | ref  | rows  | Extra                                        |
+----+-------------+-------+-------+-------------------------+-------------+---------+------+-------+----------------------------------------------+
|  1 | SIMPLE      | mv_7  | range | supp_nation,cust_nation | supp_nation | 25      | NULL | 41865 | Using where; Using temporary; Using filesort |
+----+-------------+-------+-------+-------------------------+-------------+---------+------+-------+----------------------------------------------+
4 rows in set (1.19 sec)

