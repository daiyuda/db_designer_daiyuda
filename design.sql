-- The SQL to create your design will go in this file

-- QUERY 1
CREATE TABLE mv_lineitem
    SELECT 
        l_returnflag,
        l_linestatus,
        l_shipdate,
        sum(l_quantity) as sum_qty,
        sum(l_extendedprice) as sum_base_price,
        avg(l_quantity) as avg_qty,
        avg(l_extendedprice) as avg_price,
        avg(l_discount) as avg_disc,
        count(*) as count_order
    from
        lineitem
    group by
        l_returnflag,
        l_linestatus
    order by
        l_returnflag,
        l_linestatus;