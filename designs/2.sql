-- QUERY 2

DROP INDEX size ON part;
CREATE INDEX size ON part( p_size );

DROP INDEX name ON region;
CREATE INDEX name ON region( r_name );

