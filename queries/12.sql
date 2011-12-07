-- QUERY 12
/*
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+---------------------------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                    | rows    | Extra                           |
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+---------------------------------+
|  1 | SIMPLE      | orders   | ALL    | PRIMARY       | NULL    | NULL    | NULL                   | 1500000 | Using temporary; Using filesort |
|  1 | SIMPLE      | lineitem | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.orders.O_ORDERKEY |       1 | Using where                     |
+----+-------------+----------+--------+---------------+---------+---------+------------------------+---------+---------------------------------+
*/
/*
EXPLAIN(
select
	l_shipmode,
	sum(case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then 1
		else 0
	end) as high_line_count,
	sum(case
		when o_orderpriority <> '1-URGENT'
			and o_orderpriority <> '2-HIGH'
			then 1
		else 0
	end) as low_line_count
from
	orders,
	lineitem
where
	o_orderkey = l_orderkey
	and l_shipmode in ('MAIL', 'SHIP')
	and l_commitdate < l_receiptdate
	and l_shipdate < l_commitdate
	and l_receiptdate >= date '1994-01-01'
	and l_receiptdate < date '1994-01-01' + interval '1' year
group by
	l_shipmode
order by
	l_shipmode
);
*/
explain(
select
	l_shipmode,
	sum(case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then total
		else 0
	end) as high_line_count,
	sum(case
		when o_orderpriority <> '1-URGENT'
			and o_orderpriority <> '2-HIGH'
			then total
		else 0
	end) as low_line_count
from
	mv_12
where
	l_shipmode in ('MAIL', 'SHIP')
	and l_receiptdate >= date '1994-01-01'
	and l_receiptdate < date '1994-01-01' + interval '1' year
group by
	l_shipmode
order by
	l_shipmode);

select
	l_shipmode,
	sum(case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then total
		else 0
	end) as high_line_count,
	sum(case
		when o_orderpriority <> '1-URGENT'
			and o_orderpriority <> '2-HIGH'
			then total
		else 0
	end) as low_line_count
from
	mv_12
where
	l_shipmode in ('MAIL', 'SHIP')
	and l_receiptdate >= date '1994-01-01'
	and l_receiptdate < date '1994-01-01' + interval '1' year
group by
	l_shipmode
order by
	l_shipmode;
