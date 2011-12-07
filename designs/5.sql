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

DROP INDEX custkey ON orders;
CREATE INDEX custkey ON orders ( o_custkey );

DROP INDEX orderkey ON lineitem;
CREATE INDEX orderkey ON lineitem ( l_orderkey );

DROP INDEX nationkey ON customer;
CREATE INDEX nationkey ON customer ( c_nationkey );

DROP INDEX nationkey ON supplier;
CREATE INDEX nationkey ON supplier ( s_nationkey );

DROP INDEX regionkey ON nation;
CREATE INDEX regionkey ON nation ( n_regionkey );

DROP INDEX name ON region;
CREATE INDEX name ON region ( r_name );


/*
CREATE TABLE mv_5
	SELECT 
*/