-- QUERY 1
/*
select
	l_returnflag,
	l_linestatus,
	sum(l_quantity) as sum_qty,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
	sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
	avg(l_quantity) as avg_qty,
	avg(l_extendedprice) as avg_price,
	avg(l_discount) as avg_disc,
	count(*) as count_order
from
	lineitem
where
	l_shipdate <= date '1998-12-01'
group by
	l_returnflag,
	l_linestatus
order by
	l_returnflag,
	l_linestatus;
*/
EXPLAIN(
	SELECT
		l_returnflag,
		l_linestatus,
		SUM(sum_qty) AS sum_qty,
		SUM(sum_base_price) AS sum_base_price,
		SUM(sum_disc_price) AS sum_disc_price,
		SUM(sum_charge) AS sum_charge,
		AVG(l_quantity) AS avg_qty,
		AVG(l_extendedprice) AS avg_price,
		AVG(l_discount) AS avg_disc,
		SUM(count_order) AS count_order
	FROM
		mv_1
	WHERE
		l_shipdate <= date '1998-12-01'
	GROUP BY
		l_returnflag,
		l_linestatus
	ORDER BY
		l_returnflag,
		l_linestatus
);

SELECT
	l_returnflag,
	l_linestatus,
	SUM(sum_qty) AS sum_qty,
	SUM(sum_base_price) AS sum_base_price,
	SUM(sum_disc_price) AS sum_disc_price,
	SUM(sum_charge) AS sum_charge,
	AVG(l_quantity) AS avg_qty,
	AVG(l_extendedprice) AS avg_price,
	AVG(l_discount) AS avg_disc,
	SUM(count_order) AS count_order
FROM
	mv_1
WHERE
	l_shipdate <= date '1998-12-01'
GROUP BY
	l_returnflag,
	l_linestatus
ORDER BY
	l_returnflag,
	l_linestatus;