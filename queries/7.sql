-- QUERY 7
/*
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
*/
/*
select
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
from
	(
		select
			n1.n_name as supp_nation,
			n2.n_name as cust_nation,
			extract(year from l_shipdate) as l_year,
			l_extendedprice * (1 - l_discount) as volume
		from
			supplier,
			lineitem,
			orders,
			customer,
			nation n1,
			nation n2
		where
			s_suppkey = l_suppkey
			and o_orderkey = l_orderkey
			and c_custkey = o_custkey
			and s_nationkey = n1.n_nationkey
			and c_nationkey = n2.n_nationkey
			and (
				(n1.n_name = 'FRANCE' and n2.n_name = 'GERMANY')
				or (n1.n_name = 'GERMANY' and n2.n_name = 'FRANCE')
			)
			and l_shipdate between date '1995-01-01' and date '1996-12-31'
	) as shipping
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year;
*/
explain(
select
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
FROM 
	mv_7
WHERE
	((supp_nation = 'FRANCE' and cust_nation = 'GERMANY')
		or (supp_nation = 'GERMANY' and cust_nation = 'FRANCE')	
	)
	and l_shipdate between date '1995-01-01' and date '1996-12-31'
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year);

select
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
FROM 
	mv_7
WHERE
	((supp_nation = 'FRANCE' and cust_nation = 'GERMANY')
		or (supp_nation = 'GERMANY' and cust_nation = 'FRANCE')	
	)
	and l_shipdate between date '1995-01-01' and date '1996-12-31'
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year;