-- QUERY 19
/*
+----+--------------------+----------+--------+-------------------+---------+---------+------------------------+---------+----------------------------------------------+
| id | select_type        | table    | type   | possible_keys     | key     | key_len | ref                    | rows    | Extra                                        |
+----+--------------------+----------+--------+-------------------+---------+---------+------------------------+---------+----------------------------------------------+
|  1 | PRIMARY            | nation   | ref    | PRIMARY,name      | name    | 25      | const                  |       1 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY            | orders   | ALL    | PRIMARY           | NULL    | NULL    | NULL                   | 1500000 | Using where; Using join buffer               |
|  1 | PRIMARY            | l1       | eq_ref | PRIMARY           | PRIMARY | 4       | tpch.orders.O_ORDERKEY |       1 | Using where                                  |
|  1 | PRIMARY            | supplier | eq_ref | PRIMARY,nationkey | PRIMARY | 4       | tpch.l1.L_SUPPKEY      |       1 | Using where                                  |
|  3 | DEPENDENT SUBQUERY | l3       | eq_ref | PRIMARY           | PRIMARY | 4       | tpch.l1.L_ORDERKEY     |       1 | Using where                                  |
|  2 | DEPENDENT SUBQUERY | l2       | eq_ref | PRIMARY           | PRIMARY | 4       | tpch.l1.L_ORDERKEY     |       1 | Using where                                  |
+----+--------------------+----------+--------+-------------------+---------+---------+------------------------+---------+----------------------------------------------+
*/
/*
explain(
select
	s_name,
	count(*) as numwait
from
	supplier,
	lineitem l1,
	orders,
	nation
where
	s_suppkey = l1.l_suppkey
	and o_orderkey = l1.l_orderkey
	and o_orderstatus = 'F'
	and l1.l_receiptdate > l1.l_commitdate
	and exists (
		select
			*
		from
			lineitem l2
		where
			l2.l_orderkey = l1.l_orderkey
			and l2.l_suppkey <> l1.l_suppkey
	)
	and not exists (
		select
			*
		from
			lineitem l3
		where
			l3.l_orderkey = l1.l_orderkey
			and l3.l_suppkey <> l1.l_suppkey
			and l3.l_receiptdate > l3.l_commitdate
	)
	and s_nationkey = n_nationkey
	and n_name = 'SAUDI ARABIA'
group by
	s_name
order by
	numwait desc,
	s_name);


select
	s_name,
	count(*) as numwait
from
	supplier,
	lineitem l1,
	orders,
	nation
where
	s_suppkey = l1.l_suppkey
	and o_orderkey = l1.l_orderkey
	and o_orderstatus = 'F'
	and l1.l_receiptdate > l1.l_commitdate
	and exists (
		select
			*
		from
			lineitem l2
		where
			l2.l_orderkey = l1.l_orderkey
			and l2.l_suppkey <> l1.l_suppkey
	)
	and not exists (
		select
			*
		from
			lineitem l3
		where
			l3.l_orderkey = l1.l_orderkey
			and l3.l_suppkey <> l1.l_suppkey
			and l3.l_receiptdate > l3.l_commitdate
	)
	and s_nationkey = n_nationkey
	and n_name = 'SAUDI ARABIA'
group by
	s_name
order by
	numwait desc,
	s_name;
*/
EXPLAIN(
SELECT 
	s_name,
	sum(numwait) as numwait
FROM
	mv_19
WHERE
	o_orderstatus = 'F'
	and n_name = 'SAUDI ARABIA'
group by
	s_name
order by
	numwait desc,
	s_name;
);

SELECT 
	s_name,
	sum(numwait) as numwait
FROM
	mv_19
WHERE
	o_orderstatus = 'F'
	and n_name = 'SAUDI ARABIA'
group by
	s_name
order by
	numwait desc,
	s_name;