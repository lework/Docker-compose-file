
IMAGE := lework/nomad
NOMAD_VERSION := 0.11.3

build:
	$(info Make: Building nomad images.)
	@docker-compose build --build-arg NOMAD_VERSION=$(NOMAD_VERSION) nomad_s1
	@docker tag lework/nomad:latest lework/nomad:v$(NOMAD_VERSION)

start:
	$(info Make: Starting containers.)
	docker-compose $(COMPOSE_FILE_PATH) up -d
 
stop:
	$(info Make: Stopping containers.)
	@make -s stop-jobs
	@docker-compose stop
 
restart:
	$(info Make: Restarting containers.)
	@make -s stop
	@make -s start

clean:
	$(info Make: Clean Data.)
	@rm -rf nomad/data
	@rm -rf consul/data
	@docker system prune --volumes --force
reset:
	$(info Make: Reset Cluster.)
	@make -s stop
	@make -s clean
	@make -s start
jobs:
	$(info Make: Run example jobs.)
	@docker run --rm -v $(shell pwd)/nomad/jobs:/tmp/ \
	--network nomad_nomad --entrypoint /bin/sh \
	lework/nomad:v$(NOMAD_VERSION) \
	-c "NOMAD_ADDR=http://nomad_s1:4646 nomad job run /tmp/webservice.nomad"
	@docker run --rm -v $(shell pwd)/nomad/jobs:/tmp/ \
	--network nomad_nomad --entrypoint /bin/sh \
	lework/nomad:v$(NOMAD_VERSION) \
	-c "NOMAD_ADDR=http://nomad_s1:4646 nomad job run /tmp/http-echo.nomad"
	@docker run --rm -v $(shell pwd)/nomad/jobs:/tmp/ \
	--network nomad_nomad --entrypoint /bin/sh \
	lework/nomad:v$(NOMAD_VERSION) \
	-c "NOMAD_ADDR=http://nomad_s1:4646 nomad job run /tmp/fabio.nomad"
stop-jobs:
	$(info Make: Stop all jobs.)
	@docker run --rm --network nomad_nomad --entrypoint /bin/sh \
	lework/nomad:v$(NOMAD_VERSION) \
	-c "export NOMAD_ADDR=http://nomad_s1:4646; nomad job status | awk {'print \$$1'} | grep -v '^ID' | xargs -I {} nomad job stop {}"
exec-nomad:
	@docker run --rm --network nomad_nomad --entrypoint /bin/sh \
        lework/nomad:v$(NOMAD_VERSION) \
        -c "export NOMAD_ADDR=http://nomad_s1:4646;$(cmd)"
