CREATE TABLE logs.`nginx_access_log`
(
    `timestamp` DateTime,
    `msec`  Decimal,
    `request_id` Nullable(String),
    `remote_addr` String,
    `remote_user` String,
    `host` String,
    `scheme` String,
    `uri` String,
    `request_method` String,
    `request_length` Int,
    `request_uri` String,
    `request_time` Decimal, 
    `bytes_sent` Int,
    `body_bytes_sent` Int,
    `content_length` Int,
    `content_type` String,
    `http_referer` String,
    `http_origin` String,
    `http_user_agent` String,
    `http_x_forwarded_for` Nullable(String),
    `upstream_addr` Nullable(String),
    `upstream_response_time` Nullable(Decimal),
    `upstream_header_time` Nullable(Decimal),
    `upstream_connect_time` Nullable(Decimal),
    `upstream_bytes_received` Nullable(Int),
    `upstream_status` Nullable(Int),
    `status` Int,
    `server_name` String,
    `server_port` Int,
    `server_protocol` String,

    INDEX idx_host host TYPE set(0) GRANULARITY 1
)
ENGINE = MergeTree
PARTITION BY toYYYYMMDD(timestamp)
ORDER BY timestamp
TTL timestamp + toIntervalMonth(1)
SETTINGS index_granularity = 8192;

