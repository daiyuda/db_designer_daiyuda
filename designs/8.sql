-- QUERY 8
/*
select
	o_year,
	sum(case
		when nation = 'BRAZIL' then volume
		else 0
	end) / sum(volume) as mkt_share
from
	(
		select
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) as volume,
			n2.n_name as nation
		from
			part,
			supplier,
			lineitem,
			orders,
			customer,
			nation n1,
			nation n2,
			region
		where
			p_partkey = l_partkey
			and s_suppkey = l_suppkey
			and l_orderkey = o_orderkey
			and o_custkey = c_custkey
			and c_nationkey = n1.n_nationkey
			and n1.n_regionkey = r_regionkey
			and r_name = 'AMERICA'
			and s_nationkey = n2.n_nationkey
			and o_orderdate between date '1995-01-01' and date '1996-12-31'
			and p_type = 'ECONOMY ANODIZED STEEL'
	) as all_nations
group by
	o_year
order by
	o_year;
*/

DROP TABLE IF EXISTS mv_8;
CREATE TABLE mv_8
	SELECT
		extract(year FROM o_orderdate) AS o_year,
		SUM(l_extendedprice * (1 - l_discount)) AS volume,
		n2.n_name AS nation,
		r_name,
		o_orderdate,
		p_type
	FROM
		part,
		supplier,
		lineitem,
		orders,
		customer,
		nation n1,
		nation n2,
		region
	WHERE
		p_partkey = l_partkey
		AND s_suppkey = l_suppkey
		AND l_orderkey = o_orderkey
		AND o_custkey = c_custkey
		AND c_nationkey = n1.n_nationkey
		AND n1.n_regionkey = r_regionkey
		AND s_nationkey = n2.n_nationkey
	GROUP BY
		o_year,
		nation,
		r_name,
		o_orderdate,
		p_type;

DROP INDEX name ON mv_8;
CREATE INDEX name ON mv_8 ( r_name );

DROP INDEX p_type ON mv_8;
CREATE INDEX p_type ON mv_8 ( p_type );
