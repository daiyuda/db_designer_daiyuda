-- QUERY 18
/*+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
| id | select_type | table    | type   | possible_keys | key     | key_len | ref                     | rows    | Extra       |
+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
|  1 | SIMPLE      | lineitem | ALL    | NULL          | NULL    | NULL    | NULL                    | 1500000 | Using where |
|  1 | SIMPLE      | part     | eq_ref | PRIMARY       | PRIMARY | 4       | tpch.lineitem.L_PARTKEY |       1 | Using where |
+----+-------------+----------+--------+---------------+---------+---------+-------------------------+---------+-------------+
*/
/*
EXPLAIN(
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
	)
);

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
EXPLAIN(
select
	sum(revenue) as revenue
from
	mv_18
where
	l_shipinstruct = 'DELIVER IN PERSON'
	AND l_shipmode in ('AIR', 'AIR REG')
	AND(
		(
			p_brand = 'Brand#12'
			and p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
			and l_quantity >= 1 and l_quantity <= 1 + 10
			and p_size between 1 and 5
		)
		or
		(
			p_brand = 'Brand#23'
			and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
			and l_quantity >= 10 and l_quantity <= 10 + 10
			and p_size between 1 and 10
		)
		or
		(
			p_brand = 'Brand#34'
			and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
			and l_quantity >= 20 and l_quantity <= 20 + 10
			and p_size between 1 and 15
	))
);

select
	sum(revenue) as revenue
from
	mv_18
where
	l_shipinstruct = 'DELIVER IN PERSON'
	AND l_shipmode in ('AIR', 'AIR REG')
	AND(
		(
			p_brand = 'Brand#12'
			and p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
			and l_quantity >= 1 and l_quantity <= 1 + 10
			and p_size between 1 and 5
		)
		or
		(
			p_brand = 'Brand#23'
			and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
			and l_quantity >= 10 and l_quantity <= 10 + 10
			and p_size between 1 and 10
		)
		or
		(
			p_brand = 'Brand#34'
			and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
			and l_quantity >= 20 and l_quantity <= 20 + 10
			and p_size between 1 and 15
	));