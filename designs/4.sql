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

/*
CREATE TABLE mv_4
	SELECT
		l_orderkey
	FROM
		lineitem
	WHERE
		l_commitdate < l_receiptdate;

DROP INDEX orderkey ON mv_4;
CREATE INDEX orderkey ON mv_4 (l_orderkey);
*/