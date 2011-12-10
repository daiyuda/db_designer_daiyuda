-- @author : daiyuda
-- All the rewrites of queries in the final project of cs127

-- QUERY 1


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

-- QUERY 2

select
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
from
	part,
	supplier,
	partsupp,
	nation,
	region
where
	p_partkey = ps_partkey
	and s_suppkey = ps_suppkey
	and p_size = 15
	and p_type like '%BRASS'
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'EUROPE'
	and ps_supplycost = (
		select
			min(ps_supplycost)
		from
			partsupp,
			supplier,
			nation,
			region
		where
			p_partkey = ps_partkey
			and s_suppkey = ps_suppkey
			and s_nationkey = n_nationkey
			and n_regionkey = r_regionkey
			and r_name = 'EUROPE'
	)
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey;

-- QUERY 3

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

-- QUERY 4

SELECT
	o_orderpriority,
	SUM(order_count) AS order_count
FROM
	mv_4
WHERE
	o_orderdate >= date '1993-07-01'
	AND o_orderdate < date '1993-07-01' + interval '3' month
GROUP BY
	o_orderpriority
ORDER BY
	o_orderpriority;

-- QUERY 5

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

-- QUERY 6


SELECT
	SUM(revenue) AS revenue
FROM
	mv_6
WHERE
	l_shipdate >= date '1994-01-01'
	AND l_shipdate < date '1994-01-01' + interval '1' year
	AND l_discount between .06 - 0.01 AND .06 + 0.01
	AND l_quantity < 24;

-- QUERY 7

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

-- QUERY 8

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

-- QUERY 9


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

-- QUERY 10

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
-- QUERY 11


SELECT
	ps_partkey,
	SUM(total) AS value
FROM
	mv_11
WHERE
	n_name = 'GERMANY'
GROUP BY
	ps_partkey HAVING
		SUM(total) > (
			SELECT
				SUM(total) * 0.0001000000
			FROM
				mv_11
			WHERE
				n_name = 'GERMANY'
		)
ORDER BY
	value DESC;
-- QUERY 12

SELECT
	l_shipmode,
	SUM(CASE
		WHEN o_orderpriority = '1-URGENT'
			OR o_orderpriority = '2-HIGH'
			THEN total
		ELSE 0
	END) AS high_line_count,
	SUM(CASE
		WHEN o_orderpriority <> '1-URGENT'
			AND o_orderpriority <> '2-HIGH'
			THEN total
		ELSE 0
	END) AS low_line_count
FROM
	mv_12
WHERE
	l_shipmode IN ('MAIL', 'SHIP')
	AND l_receiptdate >= date '1994-01-01'
	AND l_receiptdate < date '1994-01-01' + interval '1' year
GROUP BY
	l_shipmode
ORDER BY
	l_shipmode;

-- QUERY 14

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

-- QUERY 15


DROP VIEW IF EXISTS revenue0;

CREATE VIEW revenue0 (supplier_no, total_revenue) AS
	SELECT
		l_suppkey,
		SUM(price)
	FROM
		mv_15
	WHERE
		l_shipdate >= date '1996-01-01'
		AND l_shipdate < date '1996-01-01' + interval '3' month
	GROUP BY
		l_suppkey;



SELECT
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
FROM
	supplier,
	revenue0
WHERE
	s_suppkey = supplier_no
	AND total_revenue = (
		SELECT
			MAX(total_revenue)
		FROM
			revenue0
	)
ORDER BY
	s_suppkey;

DROP VIEW revenue0;

-- QUERY 16

SELECT
	p_brand,
	p_type,
	p_size,
	SUM(distinct supplier_cnt) AS supplier_cnt
FROM
	mv_16
WHERE
	p_brand <> 'Brand#45'
	AND p_type not like 'MEDIUM POLISHED%'
	AND p_size in (49, 14, 23, 45, 19, 3, 36, 9)
	AND ps_suppkey not in (
		SELECT
			s_suppkey
		FROM
			supplier
		WHERE
			s_comment like '%Customer%Complaints%'
	)
GROUP BY
	p_brand,
	p_type,
	p_size
ORDER BY
	supplier_cnt DESC,
	p_brand,
	p_type,
	p_size;


-- QUERY 18

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

-- QUERY 19

SELECT 
	s_name,
	SUM(numwait) AS numwait
FROM
	mv_19
WHERE
	o_orderstatus = 'F'
	AND n_name = 'SAUDI ARABIA'
GROUP BY
	s_name
ORDER BY
	numwait DESC,
	s_name;


