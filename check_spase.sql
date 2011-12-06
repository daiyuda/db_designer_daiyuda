SELECT table_schema "DB name",
	sum( data_length + index_length ) / 1024 /1024 "Total Size in MB"
FROM information_schema.TABLES
WHERE table_schema = "tpch"
GROUP BY table_schema;
