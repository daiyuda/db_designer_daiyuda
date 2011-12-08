-- QUERY 15

/*
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
| id | select_type | table      | type   | possible_keys | key     | key_len | ref                  | rows    | Extra                                        |
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
|  1 | PRIMARY     | <derived3> | ALL    | NULL          | NULL    | NULL    | NULL                 |    9968 | Using where; Using temporary; Using filesort |
|  1 | PRIMARY     | supplier   | eq_ref | PRIMARY       | PRIMARY | 4       | revenue0.supplier_no |       1 |                                              |
|  3 | DERIVED     | lineitem   | ALL    | NULL          | NULL    | NULL    | NULL                 | 1500000 | Using where; Using temporary; Using filesort |
|  2 | SUBQUERY    | <derived4> | ALL    | NULL          | NULL    | NULL    | NULL                 |    9968 |                                              |
|  4 | DERIVED     | lineitem   | ALL    | NULL          | NULL    | NULL    | NULL                 | 1500000 | Using where; Using temporary; Using filesort |
+----+-------------+------------+--------+---------------+---------+---------+----------------------+---------+----------------------------------------------+
*/
/*
drop view if exists revenue0;

create view revenue0 (supplier_no, total_revenue) as
	select
		l_suppkey,
		sum(l_extendedprice * (1 - l_discount))
	from
		lineitem
	where
		l_shipdate >= date '1996-01-01'
		and l_shipdate < date '1996-01-01' + interval '3' month
	group by
		l_suppkey;

select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	supplier,
	revenue0
where
	s_suppkey = supplier_no
	and total_revenue = (
		select
			max(total_revenue)
		from
			revenue0
	)
order by
	s_suppkey;

drop view revenue0;
*/
drop view if exists revenue0;

create view revenue0 (supplier_no, total_revenue) as
	select
		l_suppkey,
		max(price)
	from
		mv_15
	where
		l_shipdate >= date '1996-01-01'
		and l_shipdate < date '1996-01-01' + interval '3' month
	group by
		l_suppkey;

EXPLAIN(
select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	supplier,
	revenue0
where
	s_suppkey = supplier_no
	and total_revenue = (
		select
			total_revenue
		from
			revenue0
	)
order by
	s_suppkey
);

select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	supplier,
	revenue0
where
	s_suppkey = supplier_no
	and total_revenue = (
		select
			total_revenue
		from
			revenue0
	)
order by
	s_suppkey;

drop view revenue0;