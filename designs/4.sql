-- QUERY 4

DROP TABLE IF EXISTS mv_4;
CREATE TABLE mv_4
	select
		o_orderpriority,
		count(*) as order_count,
		o_orderdate
	from
		orders
	where
		exists (
		select
			*
		from
			lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority,
	o_orderdate;
