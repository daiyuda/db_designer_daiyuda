-- QUERY 2

/*
DROP TABLE IF EXISTS mv_supplycost;

CREATE TABLE mv_supplycost
	SELECT 
		ps_suppkey,
		MIN(ps_supplycost) AS supplycost,
		r_name
	FROM 
		partsupp,
		supplier,
		nation,
		region
	WHERE
		s_suppkey = ps_suppkey
		AND s_nationkey = n_nationkey
		AND n_regionkey = r_regionkey
	GROUP BY
		r_name;
*/
/*
DROP INDEX min_supply ON partsupp;
CREATE INDEX min_supply ON partsupp( ps_supplycost );
*/
DROP INDEX size ON part;
CREATE INDEX size ON part( p_size );

DROP INDEX name ON region;
CREATE INDEX name ON region( r_name );

