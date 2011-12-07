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
DROP INDEX orderpriority ON orders;
CREATE INDEX orderpriority ON orders ( o_orderpriority );
*/

DROP TABLE IF EXISTS mv_4;
CREATE TABLE mv_4
	SELECT
		l_orderkey
	FROM
		lineitem
	WHERE
		l_commitdate < l_receiptdate;
/*
ALTER TABLE mv_4
ADD PRIMARY KEY (l_orderkey);
*/
CREATE INDEX mmmm ON mv (l_orderkey);