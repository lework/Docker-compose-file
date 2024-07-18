

## 文档

- https://github.com/ClickHouse/examples/tree/main/docker-compose-recipes/recipes
- https://clickhouse.com/docs/en/architecture/replication



## cluster_1S_2R_ch_proxy


插入数据

``` 
docker exec -ti clickhouse-01 bash

clickhouse-client

CREATE DATABASE db1 ON CLUSTER cluster_1S_2R

CREATE TABLE db1.table1 ON CLUSTER cluster_1S_2R
(
    `id` UInt64,
    `column1` String
)
ENGINE = ReplicatedMergeTree
ORDER BY id

INSERT INTO db1.table1 (id, column1) VALUES (1, 'abc');

INSERT INTO db1.table1 (id, column1) VALUES (2, 'def');

SELECT * FROM db1.table1 FORMAT Pretty
```


测试 ch-proxy
```
echo "INSERT INTO db1.table1 (id, column1) VALUES (3, 'ghi');" | curl http://127.0.0.1 --data-binary @-
echo "SELECT * FROM db1.table1 FORMAT Pretty" | curl http://127.0.0.1 --data-binary @-
```


```
select concat(database, '.', table)                         as table,
       formatReadableSize(sum(bytes))                       as size,
       sum(rows)                                            as rows,
       max(modification_time)                               as latest_modification,
       sum(bytes)                                           as bytes_size,
       any(engine)                                          as engine,
       formatReadableSize(sum(primary_key_bytes_in_memory)) as primary_keys_size
from system.parts
where active
group by database, table
order by bytes_size desc;
```