-- The SQL to create your design will go in this file

-- QUERY 1

DROP TABLE IF EXISTS mv_1;
CREATE TABLE mv_1
        SELECT
                l_returnflag,
                l_linestatus,
                l_shipdate,
                SUM(l_quantity) AS sum_qty,
                SUM(l_extendedprice) AS sum_base_price,
                SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price,
                SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge,

		SUM(l_discount) AS sum_discount,

                COUNT(*) AS count_order
        FROM
                lineitem
        GROUP BY
                l_returnflag,
                l_linestatus,
                l_shipdate;

-- QUERY 2

DROP INDEX size ON part;
CREATE INDEX size ON part( p_size );

DROP INDEX name ON region;
CREATE INDEX name ON region( r_name );

-- QUERY 3

DROP TABLE IF EXISTS mv_3;
CREATE TABLE mv_3 
  SELECT 
		l_orderkey,
		sum(l_extendedprice * (1 - l_discount)) as revenue,
		o_orderdate,
		o_shippriority,
		c_mktsegment,
		l_shipdate
	FROM
		customer,
		orders,
		lineitem
	WHERE
		c_custkey = o_custkey
		AND l_orderkey = o_orderkey
	GROUP BY
		l_orderkey,
		o_orderdate,
		o_shippriority,
		c_mktsegment,
		o_orderdate,
		l_shipdate
	ORDER BY
		revenue DESC,
		o_orderdate;

DROP INDEX mktsegment ON mv_3;
CREATE INDEX mktsegment ON mv_3 ( c_mktsegment );

-- QUERY 4

DROP TABLE IF EXISTS mv_4;
CREATE TABLE mv_4
	SELECT
		o_orderpriority,
		COUNT(*) AS order_count,
		o_orderdate
	FROM
		orders
	WHERE
		EXISTS (
			SELECT
				*
			FROM
				lineitem
			WHERE
				l_orderkey = o_orderkey
				AND l_commitdate < l_receiptdate
		)
	GROUP BY
		o_orderpriority,
		o_orderdate;

-- QUERY 5

DROP TABLE IF EXISTS mv_5;
CREATE TABLE mv_5
	SELECT 
		n_name,
		SUM(l_extendedprice * (1 - l_discount)) AS revenue,
		r_name,
		o_orderdate
	FROM
		customer,
		orders,
		lineitem,
		supplier,
		nation,
		region
	WHERE
		c_custkey = o_custkey
		AND l_orderkey = o_orderkey
		AND l_suppkey = s_suppkey
		AND c_nationkey = s_nationkey
		AND s_nationkey = n_nationkey
		AND n_regionkey = r_regionkey
	GROUP BY
		n_name,
		r_name,
		o_orderdate;

DROP INDEX name ON mv_5;
CREATE INDEX name ON mv_5 ( r_name );

-- QUERY 6

DROP TABLE IF EXISTS mv_6;
CREATE TABLE mv_6 
	SELECT 
		SUM(l_extendedprice * l_discount) AS revenue,
		l_shipdate,
		l_discount,
		l_quantity
	FROM
		lineitem
	GROUP BY
		l_shipdate,
		l_discount,
		l_quantity;
/*
DROP INDEX shipdate ON mv_6;
CREATE INDEX shipdate ON mv_6 (l_shipdate);
*/

-- QUERY 7

DROP TABLE IF EXISTS mv_7;
CREATE TABLE mv_7
	SELECT 
		n1.n_name AS supp_nation,
		n2.n_name AS cust_nation,
		extract(year FROM l_shipdate) AS l_year,
		SUM(l_extendedprice * (1 - l_discount)) AS volume,
		l_shipdate
	FROM
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2
	WHERE
		s_suppkey = l_suppkey
		AND o_orderkey = l_orderkey
		AND c_custkey = o_custkey
		AND s_nationkey = n1.n_nationkey
		AND c_nationkey = n2.n_nationkey
	GROUP BY
		supp_nation,	
		cust_nation,
		l_year,
		l_shipdate;

DROP INDEX supp_nation ON mv_7;
CREATE INDEX supp_nation ON mv_7 (supp_nation);

DROP INDEX cust_nation ON mv_7;
CREATE INDEX cust_nation ON mv_7 (cust_nation);


-- QUERY 8

DROP TABLE IF EXISTS mv_8;
CREATE TABLE mv_8
	SELECT
		extract(year FROM o_orderdate) AS o_year,
		SUM(l_extendedprice * (1 - l_discount)) AS volume,
		n2.n_name AS nation,
		r_name,
		o_orderdate,
		p_type
	FROM
		part,
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2,
		region
	WHERE
		p_partkey = l_partkey
		AND s_suppkey = l_suppkey
		AND l_orderkey = o_orderkey
		AND o_custkey = c_custkey
		AND c_nationkey = n1.n_nationkey
		AND n1.n_regionkey = r_regionkey
		AND s_nationkey = n2.n_nationkey
	GROUP BY
		o_year,
		nation,
		r_name,
		o_orderdate,
		p_type;

DROP INDEX name ON mv_8;
CREATE INDEX name ON mv_8 ( r_name );

DROP INDEX p_type ON mv_8;
CREATE INDEX p_type ON mv_8 ( p_type );

-- QUERY 9

DROP TABLE IF EXISTS mv_9;
CREATE TABLE mv_9
	SELECT
		n_name AS nation,
		EXTRACT(YEAR FROM o_orderdate) AS o_year,
		SUM(l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity) AS amount,
		p_name
	FROM
		part,
		supplier,
		lineitem,
		partsupp,
		orders,
		nation
	WHERE
		s_suppkey = l_suppkey
		AND ps_suppkey = l_suppkey
		AND ps_partkey = l_partkey
		AND p_partkey = l_partkey
		AND o_orderkey = l_orderkey
		AND s_nationkey = n_nationkey
	GROUP BY
		nation,
		o_year,
		p_name;

-- QUERY 10

DROP TABLE IF EXISTS mv_10;
CREATE TABLE mv_10
	SELECT
		c_custkey,
		c_name,
		SUM(l_extendedprice * (1 - l_discount)) AS revenue,
		c_acctbal,
		n_name,
		c_address,
		c_phone,
		c_comment,
		o_orderdate,
		l_returnflag
	FROM
		customer,
		orders,
		lineitem,
		nation
	WHERE
		c_custkey = o_custkey
		AND l_orderkey = o_orderkey
		AND c_nationkey = n_nationkey
	GROUP BY
		c_custkey,
		c_name,
		c_acctbal,
		c_phone,
		n_name,
		c_address,
		c_comment,
		o_orderdate,
		l_returnflag;

DROP INDEX orderdate ON mv_10;
CREATE INDEX orderdate ON mv_10 (o_orderdate);

-- QUERY 11


DROP TABLE IF EXISTS mv_11;
CREATE TABLE mv_11
	SELECT
		ps_partkey,
		SUM(ps_supplycost * ps_availqty) AS total,
		n_name
	FROM
		partsupp,
		supplier,
		nation
	WHERE
		ps_suppkey = s_suppkey
		AND s_nationkey = n_nationkey
	GROUP BY
		ps_partkey,
		n_name;

DROP INDEX name ON mv_11;
CREATE INDEX name ON mv_11( n_name );

-- QUERY 12

DROP TABLE IF EXISTS mv_12;
CREATE TABLE mv_12
	SELECT
		l_shipmode,
		o_orderpriority,
		COUNT(o_orderpriority) AS total,
		l_receiptdate
	FROM
		orders,
		lineitem
	WHERE
		o_orderkey = l_orderkey
		AND l_commitdate < l_receiptdate
		AND l_shipdate < l_commitdate
	GROUP BY
		l_shipmode,
		o_orderpriority,
		l_receiptdate;

-- QUERY 14

DROP TABLE IF EXISTS mv_14;
CREATE TABLE mv_14
	SELECT
		p_type,
		l_extendedprice * (1 - l_discount) AS price,
		l_shipdate
	FROM
		lineitem,
		part
	WHERE
		l_partkey = p_partkey;

DROP INDEX shipdate ON mv_14;
CREATE INDEX shipdate ON mv_14 (l_shipdate);


-- QUERY 15

DROP TABLE IF EXISTS mv_15;
CREATE TABLE mv_15
	SELECT
		l_suppkey,
		l_extendedprice * (1 - l_discount) AS price,
		l_shipdate
	FROM
		lineitem
	GROUP BY
		l_suppkey,
		l_shipdate;


DROP INDEX shipdate ON mv_15;
CREATE INDEX shipdate ON mv_15(l_shipdate);

-- QUERY 16

DROP TABLE IF EXISTS mv_16;
CREATE TABLE mv_16
	SELECT
		p_brand,
		p_type,
		p_size,
		COUNT(DISTINCT ps_suppkey) AS supplier_cnt,
		ps_suppkey
	FROM
		partsupp,
		part
	WHERE
		p_partkey = ps_partkey
	GROUP BY
		p_brand,
		p_type,
		p_size,
		ps_suppkey;

/*
DROP INDEX size ON mv_16;
CREATE INDEX size ON mv_16 (p_size);
*/

-- QUERY 18

DROP TABLE IF EXISTS mv_18;
CREATE TABLE mv_18
	SELECT
		SUM(l_extendedprice* (1 - l_discount)) AS revenue,
		p_brand,
		p_container,
		l_quantity,
		p_size,
		l_shipmode,
		l_shipinstruct
	FROM
		lineitem,
		part
	WHERE
		p_partkey = l_partkey
	GROUP BY
		p_brand,
		p_container,
		l_quantity,
		p_size,
		l_shipmode,
		l_shipinstruct;
/*
DROP INDEX brand ON mv_18;
CREATE INDEX brand ON mv_18 ( p_brand );

DROP INDEX shipinstruct ON mv_18;
CREATE INDEX shipinstruct on mv_18 ( l_shipinstruct);
*/

-- QUERY 19

DROP TABLE IF EXISTS mv_19;
CREATE TABLE mv_19
	SELECT
		s_name,
		COUNT(*) AS numwait,
		o_orderstatus,
		n_name
	FROM
		supplier,
		lineitem l1,
		orders,
		nation
	WHERE
		s_suppkey = l1.l_suppkey
		AND o_orderkey = l1.l_orderkey
		AND l1.l_receiptdate > l1.l_commitdate
		AND exists (
			SELECT
				*
			FROM
				lineitem l2
			WHERE
				l2.l_orderkey = l1.l_orderkey
				AND l2.l_suppkey <> l1.l_suppkey
		)
		AND NOT EXISTS (
			SELECT
				*
			FROM
				lineitem l3
			WHERE
				l3.l_orderkey = l1.l_orderkey
				AND l3.l_suppkey <> l1.l_suppkey
				AND l3.l_receiptdate > l3.l_commitdate
		)
		AND s_nationkey = n_nationkey
	GROUP BY
		s_name,
		o_orderstatus,
		n_name;

