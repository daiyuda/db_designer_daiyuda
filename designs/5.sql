-- QUERY 5
/*
select
	n_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue
from
	customer,
	orders,
	lineitem,
	supplier,
	nation,
	region
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'ASIA'
	and o_orderdate >= date '1994-01-01'
	and o_orderdate < date '1994-01-01' + interval '1' year
group by
	n_name
order by
	revenue desc;
*/

DROP TABLE IF EXISTS mv_5;
CREATE TABLE mv_5
	SELECT 
		n_name,
		sum(l_extendedprice * (1 - l_discount)) as revenue,
		r_name,
		o_orderdate
	from
		customer,
		orders,
		lineitem,
		supplier,
		nation,
		region
	where
		c_custkey = o_custkey
		and l_orderkey = o_orderkey
		and l_suppkey = s_suppkey
		and c_nationkey = s_nationkey
		and s_nationkey = n_nationkey
		and n_regionkey = r_regionkey
	group by
		n_name,
		r_name,
		o_orderdate;

DROP INDEX name ON mv_5;
CREATE INDEX name ON mv_5 ( r_name );
