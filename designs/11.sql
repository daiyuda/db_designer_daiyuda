-- QUERY 11
/*
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
	value desc;
*/

DROP TABLE IF EXISTS mv_11;
CREATE TABLE mv_11
	select
		sum(ps_supplycost * ps_availqty) * 0.0001000000 as total,
		n_name
	from
		partsupp,
		supplier,
		nation
	where
		ps_suppkey = s_suppkey
		and s_nationkey = n_nationkey
	GROUP BY
		n_name;

DROP INDEX suppkey ON partsupp;
CREATE INDEX suppkey ON partsupp(ps_suppkey);

DROP INDEX nationkey ON supplier;
CREATE INDEX nationkey ON supplier(s_nationkey);
create index nationkey on supplier(s_nationkey);