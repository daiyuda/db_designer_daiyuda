-- QUERY 9
/*
select
	nation,
	o_year,
	sum(amount) as sum_profit
from
	(
		select
			n_name as nation,
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
		from
			part,
			supplier,
			lineitem,
			partsupp,
			orders,
			nation
		where
			s_suppkey = l_suppkey
			and ps_suppkey = l_suppkey
			and ps_partkey = l_partkey
			and p_partkey = l_partkey
			and o_orderkey = l_orderkey
			and s_nationkey = n_nationkey
			and p_name like '%green%'
	) as profit
group by
	nation,
	o_year
order by
	nation,
	o_year desc;
*/
DROP TABLE IF EXISTS mv_9;
CREATE TABLE mv_9
	SELECT
		n_name AS nation,
		EXTRACT(YEAR FROM o_orderdate) AS o_year,
		SUM(l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity) AS amount,
		p_name
	FROM
		part,
		supplier,
		lineitem,
		partsupp,
		orders,
		nation
	WHERE
		s_suppkey = l_suppkey
		AND ps_suppkey = l_suppkey
		AND ps_partkey = l_partkey
		AND p_partkey = l_partkey
		AND o_orderkey = l_orderkey
		AND s_nationkey = n_nationkey
	GROUP BY
		nation,
		o_year,
		p_name;
