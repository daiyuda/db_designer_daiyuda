-- QUERY 11
/*
explain(
select
	ps_partkey,
	sum(ps_supplycost * ps_availqty) as value
from
	partsupp,
	supplier,
	nation
where
	ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_name = 'GERMANY'
group by
	ps_partkey having
		sum(ps_supplycost * ps_availqty) > (
			select
				sum(ps_supplycost * ps_availqty) * 0.0001000000
			from
				partsupp,
				supplier,
				nation
			where
				ps_suppkey = s_suppkey
				and s_nationkey = n_nationkey
				and n_name = 'GERMANY'
		)
order by
	value desc
);
*/
EXPLAIN(
	SELECT
		ps_partkey,
		SUM(ps_supplycost * ps_availqty) AS value
	FROM
		partsupp,
		supplier,
		nation
	WHERE
		ps_suppkey = s_suppkey
		AND s_nationkey = n_nationkey
		AND n_name = 'GERMANY'
	GROUP BY
		ps_partkey HAVING
			SUM(ps_supplycost * ps_availqty) > (
				SELECT
					total
				FROM
					mv_11
				WHERE
					n_name = 'GERMANY'
			)
	ORDER BY
		value DESC
);

SELECT
	ps_partkey,
	SUM(ps_supplycost * ps_availqty) AS value
FROM
	partsupp,
	supplier,
	nation
WHERE
	ps_suppkey = s_suppkey
	AND s_nationkey = n_nationkey
	AND n_name = 'GERMANY'
GROUP BY
	ps_partkey HAVING
		SUM(ps_supplycost * ps_availqty) > (
			SELECT
				total
			FROM
				mv_11
			WHERE
				n_name = 'GERMANY'
		)
ORDER BY
	value DESC