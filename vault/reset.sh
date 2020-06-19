#!/bin/bash

docker-compose down
find ./ -name *.log -exec rm -fv {} \;
rm -rf consul/data

chmod +x {consul,vault}/config/*.sh
docker-compose up -d