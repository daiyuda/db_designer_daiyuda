-- QUERY 1

DROP TABLE IF EXISTS mv_1;
CREATE TABLE mv_1
        SELECT
                l_returnflag,
                l_linestatus,
                l_shipdate,
                SUM(l_quantity) AS sum_qty,
                SUM(l_extendedprice) AS sum_base_price,
                SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price,
                SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge,

		SUM(l_discount) AS sum_discount,

                COUNT(*) AS count_order
        FROM
                lineitem
        GROUP BY
                l_returnflag,
                l_linestatus,
                l_shipdate;
