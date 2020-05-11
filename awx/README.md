
启动
```bash
mkdir redis_socket memcached_socket
chmod 777 redis_socket memcached_socket
chmod 0666 redis.conf
chmod 0600 SECRET_KEY
docker-compose up -d
```


启动后，更新ca

```bash
docker exec awx_web '/usr/bin/update-ca-trust'
docker exec awx_task '/usr/bin/update-ca-trust'
```