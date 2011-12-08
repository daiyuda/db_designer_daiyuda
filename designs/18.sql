-- QUERY 18
/*
select
	sum(l_extendedprice* (1 - l_discount)) as revenue
from
	lineitem,
	part
where
	(
		p_partkey = l_partkey
		and p_brand = 'Brand#12'
		and p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		and l_quantity >= 1 and l_quantity <= 1 + 10
		and p_size between 1 and 5
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p_partkey = l_partkey
		and p_brand = 'Brand#23'
		and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		and l_quantity >= 10 and l_quantity <= 10 + 10
		and p_size between 1 and 10
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p_partkey = l_partkey
		and p_brand = 'Brand#34'
		and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		and l_quantity >= 20 and l_quantity <= 20 + 10
		and p_size between 1 and 15
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	);
*/

DROP TABLE IF EXISTS mv_18;
CREATE TABLE mv_18
	SELECT
		SUM(l_extendedprice* (1 - l_discount)) AS revenue,
		p_brand,
		p_container,
		l_quantity,
		p_size,
		l_shipmode,
		l_shipinstruct
	FROM
		lineitem,
		part
	WHERE
		p_partkey = l_partkey
	GROUP BY
		p_brand,
		p_container,
		l_quantity,
		p_size,
		l_shipmode,
		l_shipinstruct;
/*
DROP INDEX brand ON mv_18;
CREATE INDEX brand ON mv_18 ( p_brand );

DROP INDEX shipinstruct ON mv_18;
CREATE INDEX shipinstruct on mv_18 ( l_shipinstruct);
*/