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
SELECT
	o_orderpriority,
	COUNT(*) AS order_count
FROM
	(
		SELECT 
			*
		FROM 
			orders
		WHERE
			o_orderdate >= date '1993-07-01'
			and o_orderdate < date '1993-07-01' + interval '3' month
	)
		AS o,
	(
		SELECT 
			* 
		FROM
			lineitem
		WHERE
			l_commitdate < l_receiptdate	
	)
		AS l
WHERE
	o.o_orderkey = l.l_orderkey
group by
	o_orderpriority
order by
	o_orderpriority;

