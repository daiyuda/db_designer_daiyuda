-- QUERY 8
/*
+----+-------------+------------+--------+---------------+---------+---------+---------------------------+---------+---------------------------------+
| id | select_type | table      | type   | possible_keys | key     | key_len | ref                       | rows    | Extra                           |
+----+-------------+------------+--------+---------------+---------+---------+---------------------------+---------+---------------------------------+
|  1 | PRIMARY     | <derived2> | ALL    | NULL          | NULL    | NULL    | NULL                      |     642 | Using temporary; Using filesort |
|  2 | DERIVED     | region     | ref    | PRIMARY,name  | name    | 25      |                           |       1 | Using where                     |
|  2 | DERIVED     | orders     | ALL    | PRIMARY       | NULL    | NULL    | NULL                      | 1500000 | Using where; Using join buffer  |
|  2 | DERIVED     | customer   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_CUSTKEY     |       1 |                                 |
|  2 | DERIVED     | lineitem   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY    |       1 |                                 |
|  2 | DERIVED     | part       | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_PARTKEY   |       1 | Using where                     |
|  2 | DERIVED     | supplier   | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_SUPPKEY   |       1 |                                 |
|  2 | DERIVED     | n2         | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.supplier.S_NATIONKEY |       1 |                                 |
|  2 | DERIVED     | n1         | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.customer.C_NATIONKEY |       1 | Using where                     |
+----+-------------+------------+--------+---------------+---------+---------+---------------------------+---------+---------------------------------+
*/
/*
explain(
select
	o_year,
	sum(case
		when nation = 'BRAZIL' then volume
		else 0
	end) / sum(volume) as mkt_share
from
	(
		select
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) as volume,
			n2.n_name as nation
		from
			part,
			supplier,
			lineitem,
			orders,
			customer,
			nation n1,
			nation n2,
			region
		where
			p_partkey = l_partkey
			and s_suppkey = l_suppkey
			and l_orderkey = o_orderkey
			and o_custkey = c_custkey
			and c_nationkey = n1.n_nationkey
			and n1.n_regionkey = r_regionkey
			and r_name = 'AMERICA'
			and s_nationkey = n2.n_nationkey
			and o_orderdate between date '1995-01-01' and date '1996-12-31'
			and p_type = 'ECONOMY ANODIZED STEEL'
	) as all_nations
group by
	o_year
order by
	o_year);
*/
EXPLAIN(
	SELECT
		o_year,
		SUM(CASE
			WHEN nation = 'BRAZIL' then volume
			ELSE 0
		END) / SUM(volume) AS mkt_share
	FROM
		mv_8
	WHERE
		r_name = 'AMERICA'
		AND o_orderdate between date '1995-01-01' and date '1996-12-31'
		AND p_type = 'ECONOMY ANODIZED STEEL'
	GROUP BY
		o_year
	ORDER BY
		o_year
);

SELECT
	o_year,
	SUM(CASE
		WHEN nation = 'BRAZIL' then volume
		ELSE 0
	END) / SUM(volume) AS mkt_share
FROM
	mv_8
WHERE
	r_name = 'AMERICA'
	AND o_orderdate between date '1995-01-01' and date '1996-12-31'
	AND p_type = 'ECONOMY ANODIZED STEEL'
GROUP BY
	o_year
ORDER BY
	o_year;
