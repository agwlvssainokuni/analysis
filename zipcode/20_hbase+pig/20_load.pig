zips = LOAD 'hbase://zips' USING
	org.apache.pig.backend.hadoop.hbase.HBaseStorage('c1:* c2:* rm:*');

DESCRIBE zips;
EXPLAIN zips;
DUMP zips;
