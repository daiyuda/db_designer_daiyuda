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

EXPLAIN(
	SELECT
		o_orderpriority,
		SUM(order_count) AS order_count
	FROM
		mv_4
	WHERE
		o_orderdate >= date '1993-07-01'
		AND o_orderdate < date '1993-07-01' + interval '3' month
	GROUP BY
		o_orderpriority
	ORDER BY
		o_orderpriority
);

SELECT
	o_orderpriority,
	SUM(order_count) AS order_count
FROM
	mv_4
WHERE
	o_orderdate >= date '1993-07-01'
	AND o_orderdate < date '1993-07-01' + interval '3' month
GROUP BY
	o_orderpriority
ORDER BY
	o_orderpriority;