-- QUERY 10
/*
EXPLAIN(
select
	c_custkey,
	c_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
from
	customer,
	orders,
	lineitem,
	nation
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate >= date '1993-10-01'
	and o_orderdate < date '1993-10-01' + interval '3' month
	and l_returnflag = 'R'
	and c_nationkey = n_nationkey
group by
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
order by
	revenue desc);
*/
explain(
	SELECT
		c_custkey,
		c_name,
		SUM(revenue) AS revenue,
		c_acctbal,
		n_name,
		c_address,
		c_phone,
		c_comment
	FROM
		mv_10
	WHERE
		o_orderdate >= date '1993-10-01'
		AND o_orderdate < date '1993-10-01' + interval '3' month
		AND l_returnflag = 'R'
	GROUP BY
		c_custkey,
		c_name,
		c_acctbal,
		c_phone,
		n_name,
		c_address,
		c_comment
	ORDER BY
		revenue DESC
);

SELECT
	c_custkey,
	c_name,
	SUM(revenue) AS revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
FROM
	mv_10
WHERE
	o_orderdate >= date '1993-10-01'
	AND o_orderdate < date '1993-10-01' + interval '3' month
	AND l_returnflag = 'R'
GROUP BY
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
ORDER BY
	revenue DESC;
