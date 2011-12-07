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
*/
/*EXPLAIN(
select
	n_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue
from
	customer,
	orders,
	lineitem,
	supplier,
	nation,
	region
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'ASIA'
	and o_orderdate >= date '1994-01-01'
	and o_orderdate < date '1994-01-01' + interval '1' year
group by
	n_name
order by
	revenue desc);


select
	n_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue
from
	customer,
	orders,
	lineitem,
	supplier,
	nation,
	region
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'ASIA'
	and o_orderdate >= date '1994-01-01'
	and o_orderdate < date '1994-01-01' + interval '1' year
group by
	n_name
order by
	revenue desc;
*/
explain(
select
	n_name,
	revenue
from
	mv_5
where
	r_name = 'ASIA'
	and o_orderdate >= date '1994-01-01'
	and o_orderdate < date '1994-01-01' + interval '1' year
);

select
	n_name,
	revenue
from
	mv_5
where
	r_name = 'ASIA'
	and o_orderdate >= date '1994-01-01'
	and o_orderdate < date '1994-01-01' + interval '1' year;