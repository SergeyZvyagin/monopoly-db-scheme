#!/bin/bash
docker build -t monopoly-postgres .
container_id=$(docker run -d -p 5432:5432 --name mp monopoly-postgres)
echo $container_id

