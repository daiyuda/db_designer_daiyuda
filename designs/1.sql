-- QUERY 1
DROP TABLE IF EXISTS mv_1;
CREATE TABLE mv_1
        SELECT
                l_returnflag,
                l_linestatus,
                l_shipdate,
                l_discount,
                l_tax,
                SUM(l_quantity) AS sum_qty,
                SUM(l_extendedprice) AS sum_base_price,
                AVG(l_quantity) AS avg_qty,
                AVG(l_extendedprice) AS avg_price,
                AVG(l_discount) AS avg_disc,
                COUNT(*) AS count_order
        FROM
                lineitem
        GROUP BY
                l_returnflag,
                l_linestatus
        ORDER BY
                l_returnflag,
                l_linestatus;