
start:
	$(info Make: Starting single containers.)
	sysctl -w vm.max_map_count=262144
	docker-compose -f docker-compose-single.yml up -d
stop:
	$(info Make: Stop single containers.)
	docker-compose -f docker-compose-single.yml down -v


start-cluster:
	$(info Make: Starting cluster containers.)
	sysctl -w vm.max_map_count=262144
	docker-compose -f docker-compose-cluster.yml up -d
stop-cluster:
	$(info Make: Stop cluster containers.)
	docker-compose -f docker-compose-cluster.yml down -v

start-xpack:
	$(info Make: Starting xpack containers.)
	sysctl -w vm.max_map_count=262144
	docker-compose -f docker-compose-xpack-certs.yml run --rm create_certs
	docker-compose -f docker-compose-xpack.yml up -d
stop-xpack:
	$(info Make: Stop xpack containers.)
	docker-compose -f docker-compose-xpack.yml down -v

start-stack:
	$(info Make: Starting stack containers.)
	sysctl -w vm.max_map_count=262144
	docker-compose --env-file stack/stack.env -f docker-compose-stack.yml up -d
stop-stack:
	$(info Make: Stop stack containers.)
	docker-compose --env-file stack/stack.env -f docker-compose-stack.yml down -v
