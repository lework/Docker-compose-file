#!/bin/bash


docker exec gogs bash -c "export USER=git && /app/gogs/gogs backup --target /data/backup/" 
