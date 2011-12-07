-- QUERY 4
/*
select
	o_orderpriority,
	count(*) as order_count
from
	orders
where
	o_orderdate >= date '1993-07-01'
	and o_orderdate < date '1993-07-01' + interval '3' month
	and exists (
		select
			*
		from
			lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority;
*/
/*
select
	o_orderpriority,
	sum(order_count) as order_count
from
	orders
where
	o_orderdate >= date '1993-07-01'
	and o_orderdate < date '1993-07-01' + interval '3' month
	and exists (
		select
			*
		from
			mv_4
		where
			l_orderkey = o_orderkey
	)
group by
	o_orderpriority
order by
	o_orderpriority;
*/
explain(
select
	o_orderpriority,
	count(*) as order_count
from
	mv_4
where
	o_orderdate >= date '1993-07-01'
	and o_orderdate < date '1993-07-01' + interval '3' month
group by
	o_orderpriority
order by
	o_orderpriority);

select
	o_orderpriority,
	count(*) as order_count
from
	mv_4
where
	o_orderdate >= date '1993-07-01'
	and o_orderdate < date '1993-07-01' + interval '3' month
group by
	o_orderpriority
order by
	o_orderpriority;